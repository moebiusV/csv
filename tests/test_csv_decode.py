"""Non-UTF-8 input must fail cleanly (no traceback) for every subcommand."""
import subprocess
import sys
from pathlib import Path

CSV = Path(__file__).parent.parent / "csv"

LATIN1 = "a,b\n\xe9\xe9,\xff\n".encode("latin-1")


def run_csv(argv):
    return subprocess.run(
        [sys.executable, str(CSV), *argv],
        capture_output=True,
        text=True,
    )


def cases(data):
    s = str(data)
    return [
        ["wc", s],
        ["head", s],
        ["tail", s],
        ["cut", "a", "-f", s],
        ["pick", "1", "-f", s],
        ["grep", "e", "-f", s],
        ["sort", "-f", s],
    ]


def test_non_utf8_fails_cleanly(tmp_path):
    data = tmp_path / "latin1.csv"
    data.write_bytes(LATIN1)
    for argv in cases(data):
        proc = run_csv(argv)
        assert proc.returncode == 1, (argv, proc.stdout, proc.stderr)
        assert "Traceback" not in proc.stderr, (argv, proc.stderr)
        assert "invalid UTF-8" in proc.stderr, (argv, proc.stderr)
