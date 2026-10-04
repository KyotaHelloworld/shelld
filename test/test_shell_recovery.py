"""Run real Bash/Zsh against disposable HOME and account/package mocks."""
import os
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]


class RecoveryTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix='shelld-recovery-')
        self.addCleanup(self.tmp.cleanup)
        self.base = Path(self.tmp.name)
        self.home = self.base / 'home with spaces'
        self.home.mkdir()
        self.bin = self.base / 'bin'
        self.bin.mkdir()
        self.env = {'HOME': str(self.home), 'PATH': str(self.bin),
                    'LANG': 'C', 'MOCK_BIN': str(self.bin),
                    'MOCK_STATE': str(self.base / 'account')}
        Path(self.env['MOCK_STATE']).write_text('/usr/bin/bash\n')
        for name in ('dirname', 'cat', 'ln', 'mktemp', 'cmp', 'rm'):
            (self.bin / name).symlink_to('/usr/bin/' + name)

    def mock(self, name, body):
        path = self.bin / name
        path.write_text('#!/bin/bash\n' + body + '\n')
        path.chmod(0o755)

    def run_script(self, script, *args):
        return subprocess.run(['/usr/bin/bash', '--noprofile', '--norc',
                               str(ROOT / script), *args], env=self.env,
                              text=True, capture_output=True, timeout=10)

    def account_mocks(self):
        self.mock('id', 'printf "fixture\\n"')
        self.mock('getent', 'printf "fixture:x:1:1:Fixture:/synthetic:%s\\n" "$(cat "$MOCK_STATE")"')
        self.mock('chsh', 'printf "%s\\n" "$2" > "$MOCK_STATE"')

    def test_package_progress_does_not_contaminate_shell_path(self):
        self.account_mocks()
        self.mock('paru', 'printf "install progress\\n"; ln -s /usr/bin/zsh "$MOCK_BIN/zsh"')
        result = self.run_script('install/change-shell.sh', 'zsh')
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(Path(self.env['MOCK_STATE']).read_text(), str(self.bin / 'zsh') + '\n')
        self.assertIn('install progress', result.stderr)

    def test_package_failure_stops_account_change_then_retry_succeeds(self):
        self.account_mocks()
        self.mock('paru', 'printf "partial progress\\n"; exit 17')
        result = self.run_script('install/change-shell.sh', 'zsh')
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(Path(self.env['MOCK_STATE']).read_text(), '/usr/bin/bash\n')
        self.mock('paru', 'ln -s /usr/bin/zsh "$MOCK_BIN/zsh"')
        self.assertEqual(self.run_script('install/change-shell.sh', 'zsh').returncode, 0)

    def test_chsh_failure_keeps_account_then_retry_succeeds(self):
        self.account_mocks()
        (self.bin / 'zsh').symlink_to('/usr/bin/zsh')
        self.mock('chsh', 'exit 23')
        result = self.run_script('install/change-shell.sh', 'zsh')
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(Path(self.env['MOCK_STATE']).read_text(), '/usr/bin/bash\n')
        self.account_mocks()
        self.assertEqual(self.run_script('install/change-shell.sh', 'zsh').returncode, 0)

    def test_install_and_restore_failure_exposes_intact_backup(self):
        for target in ('bash', 'zsh'):
            with self.subTest(target=target):
                rc = self.home / ('.' + target + 'rc')
                rc.write_bytes(b'original rc\n')
                self.mock('mv', 'case "$2" in *.shelld-new.*|*/.shelld-backup.*/*) exit 19;; esac\nexec /usr/bin/mv "$@"')
                result = self.run_script('install/install.sh', target)
                self.assertNotEqual(result.returncode, 0)
                backups = list(self.home.glob('.shelld-backup.*/.' + target + 'rc'))
                self.assertEqual(len(backups), 1)
                self.assertEqual(backups[0].read_bytes(), b'original rc\n')
                self.assertIn(str(backups[0]), result.stdout + result.stderr)
                self.assertIn('Could not restore', result.stderr)
                self.assertFalse(rc.exists())
                self.assertEqual(list(self.home.glob('.*rc.shelld-new.*')), [])

    def test_failed_install_restores_rc_and_retry_is_idempotent(self):
        rc = self.home / '.bashrc'
        rc.write_bytes(b'original rc\n')
        self.mock('mv', 'case "$2" in *.shelld-new.*) exit 19;; esac\nexec /usr/bin/mv "$@"')
        self.assertNotEqual(self.run_script('install/install.sh', 'bash').returncode, 0)
        self.assertEqual(rc.read_bytes(), b'original rc\n')
        self.mock('mv', 'exec /usr/bin/mv "$@"')
        self.assertEqual(self.run_script('install/install.sh', 'bash').returncode, 0)
        backups = list(self.home.glob('.shelld-backup.*'))
        self.assertEqual(self.run_script('install/install.sh', 'bash').returncode, 0)
        self.assertEqual(list(self.home.glob('.shelld-backup.*')), backups)

    def test_goenv_failed_output_is_not_evaluated_and_success_is(self):
        for shell, flags in (('bash', ['--noprofile', '--norc']), ('zsh', ['-f'])):
            for success in (False, True):
                with self.subTest(shell=shell, success=success):
                    self.mock('goenv', 'printf "export SHELLD_PARTIAL=executed\\n"; exit ' + ('0' if success else '17'))
                    result = subprocess.run(['/usr/bin/' + shell, *flags, '-c',
                                             'source "$1"; printf "partial=%s\\n" "${SHELLD_PARTIAL-unset}"',
                                             'fixture', str(ROOT / 'common/golang/golang.sh')],
                                            env=self.env, text=True, capture_output=True, timeout=10)
                    self.assertEqual(result.returncode, 0, result.stderr)
                    self.assertEqual(result.stdout, 'partial=' + ('executed' if success else 'unset') + '\n')
                    if not success:
                        self.assertIn('goenv init failed', result.stderr)


if __name__ == '__main__':
    unittest.main()
