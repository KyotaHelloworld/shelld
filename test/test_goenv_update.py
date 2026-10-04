"""Real Bash standalone updater with disposable HOME and only mock external commands."""
from pathlib import Path
import subprocess
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]

class GoenvUpdateTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory(prefix='shelld-goenv-update-')
        self.addCleanup(self.tmp.cleanup)
        self.base = Path(self.tmp.name)
        self.home = self.base / 'home with spaces'
        self.home.mkdir()
        self.bin = self.base / 'bin'
        self.bin.mkdir()
        self.log = self.base / 'calls'
        self.env = {'HOME': str(self.home), 'PATH': str(self.bin), 'LANG': 'C',
                    'MOCK_LOG': str(self.log), 'MOCK_GIT_STATUS': '0', 'MOCK_INSTALL_STATUS': '0', 'MOCK_GLOBAL_STATUS': '0', 'MOCK_RELOAD_STATUS': '0'}
        (self.bin / 'tail').symlink_to('/usr/bin/tail')
        (self.bin / 'cat').symlink_to('/usr/bin/cat')
        self.mock('git', 'printf "git:%s:%s:%s\\n" "$1" "$2" "$3" >> "$MOCK_LOG"; exit "$MOCK_GIT_STATUS"')
        self.mock('goenv', 'printf "goenv:%s:%s\\n" "$1" "${2:-}" >> "$MOCK_LOG"; if [[ "$1" == install && "${2:-}" != -l ]]; then exit "$MOCK_INSTALL_STATUS"; fi; if [[ "$1" == global ]]; then printf "global-fixture-output\\n" >&2; exit "$MOCK_GLOBAL_STATUS"; fi; printf "fixture-version\\n"')
        self.mock('rerun', 'printf "rerun\\n" >> "$MOCK_LOG"; exit "$MOCK_RELOAD_STATUS"')
        self.mock('go', 'printf "go:%s\\n" "$1" >> "$MOCK_LOG"')

    def mock(self, name, body):
        p = self.bin / name
        p.write_text('#!/bin/bash\n' + body + '\n')
        p.chmod(0o755)

    def run_update(self, version='1.2.3'):
        return subprocess.run(['/usr/bin/bash', '--noprofile', '--norc',
                               str(ROOT / 'common/golang/install-goenv.sh'), 'update', version],
                              env=self.env, text=True, capture_output=True, timeout=5)

    def calls(self):
        return self.log.read_text().splitlines() if self.log.exists() else []

    def test_failed_update_preserves_status_and_stops_version_changes(self):
        self.env['MOCK_GIT_STATUS'] = '17'
        result = self.run_update()
        self.assertEqual(result.returncode, 17, result.stderr)
        self.assertEqual(self.calls(), [f'git:-C:{self.home}/.goenv:pull'])
        self.assertIn('goenv update failed', result.stderr)

    def test_missing_goenv_stops_before_git(self):
        (self.bin / 'goenv').unlink()
        result = self.run_update()
        self.assertEqual(result.returncode, 2)
        self.assertEqual(self.calls(), [])
        self.assertIn('INSTALL GOENV', result.stderr)

    def test_success_preserves_existing_version_flow(self):
        result = self.run_update()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.calls(), [f'git:-C:{self.home}/.goenv:pull', 'goenv:-v:',
                                      'goenv:install:1.2.3', 'goenv:global:1.2.3', 'rerun', 'go:version'])

    def test_install_failure_propagates_without_global_or_restart(self):
        self.env['MOCK_INSTALL_STATUS'] = '19'
        result = self.run_update()
        self.assertEqual(result.returncode, 1)
        self.assertFalse(any(x.startswith(('goenv:global:', 'rerun', 'go:')) for x in self.calls()))

    def test_global_failure_preserves_status_output_and_stops_reload(self):
        self.env['MOCK_GLOBAL_STATUS'] = '23'
        result = self.run_update()
        self.assertEqual(result.returncode, 23, result.stderr)
        self.assertIn('global-fixture-output', result.stderr)
        self.assertIn('global selection failed', result.stderr)
        self.assertEqual(self.calls()[-2:], ['goenv:install:1.2.3', 'goenv:global:1.2.3'])
        self.assertNotIn('rerun', self.calls())
        self.assertNotIn('go:version', self.calls())

    def test_reload_failure_preserves_status_and_stops_version_display(self):
        self.env['MOCK_RELOAD_STATUS'] = '29'
        result = self.run_update()
        self.assertEqual(result.returncode, 29, result.stderr)
        self.assertIn('selected version was not rolled back', result.stderr)
        self.assertEqual(self.calls()[-2:], ['goenv:global:1.2.3', 'rerun'])
        self.assertNotIn('go:version', self.calls())

    def test_missing_reload_is_nonzero_after_selection(self):
        (self.bin / 'rerun').unlink()
        result = self.run_update()
        self.assertEqual(result.returncode, 127, result.stderr)
        self.assertIn('Open a new shell', result.stderr)
        self.assertEqual(self.calls()[-1], 'goenv:global:1.2.3')
        self.assertNotIn('go:version', self.calls())

    def test_global_failure_then_explicit_retry_preserves_success_sequence(self):
        self.env['MOCK_GLOBAL_STATUS'] = '23'
        self.assertEqual(self.run_update().returncode, 23)
        self.log.unlink()
        self.env['MOCK_GLOBAL_STATUS'] = '0'
        self.assertEqual(self.run_update().returncode, 0)
        self.assertEqual(self.calls()[-4:], ['goenv:install:1.2.3', 'goenv:global:1.2.3', 'rerun', 'go:version'])

    def test_failed_update_then_retry_without_version(self):
        self.env['MOCK_GIT_STATUS'] = '17'
        self.assertEqual(self.run_update('').returncode, 17)
        self.log.unlink()
        self.env['MOCK_GIT_STATUS'] = '0'
        self.assertEqual(self.run_update('').returncode, 0)
        self.assertEqual(self.calls(), [f'git:-C:{self.home}/.goenv:pull', 'goenv:-v:', 'goenv:install:-l'])

    def test_help_does_not_run_external_mutations(self):
        result = subprocess.run(['/usr/bin/bash', str(ROOT / 'common/golang/install-goenv.sh'), '--help'],
                                env=self.env, text=True, capture_output=True, timeout=5)
        self.assertEqual(result.returncode, 0)
        self.assertIn('Usage:', result.stdout)
        self.assertEqual(self.calls(), [])

    def test_sourced_failure_returns_without_exiting_caller(self):
        self.env['MOCK_GIT_STATUS'] = '17'
        result = subprocess.run(['/usr/bin/bash', '--noprofile', '--norc', '-c',
                                 'source "$1" update 1.2.3; result=$?; printf "caller-alive status=%s\\n" "$result"',
                                 'fixture', str(ROOT / 'common/golang/install-goenv.sh')],
                                env=self.env, text=True, capture_output=True, timeout=5)
        self.assertEqual(result.returncode, 0)
        self.assertIn('caller-alive status=17', result.stdout)
        self.assertEqual(self.calls(), [f'git:-C:{self.home}/.goenv:pull'])

    def test_source_keeps_existing_caller_main_and_help(self):
        self.env['MOCK_GIT_STATUS'] = '17'
        result = subprocess.run(['/usr/bin/bash', '--noprofile', '--norc', '-c',
                                 'main() { printf "caller-main\\n"; }; help() { printf "caller-help\\n"; }; '
                                 'source "$1" update; result=$?; help; main; printf "status=%s\\n" "$result"',
                                 'fixture', str(ROOT / 'common/golang/install-goenv.sh')],
                                env=self.env, text=True, capture_output=True, timeout=5)
        self.assertEqual(result.returncode, 0)
        self.assertEqual(result.stdout, 'caller-help\ncaller-main\nstatus=17\n')

if __name__ == '__main__':
    unittest.main()
