# csv - Unix-style CSV Processor

[Index: All Projects](https://moebiusv.github.io/) | [github.com/moebiusV/csv](https://github.com/moebiusV/csv) | `git clone https://github.com/moebiusV/csv`

**csv** is a lightweight, single-binary command-line tool that brings familiar Unix classics like `head`, `tail`, `wc`, `cut`, `grep`, and `sort` to CSV files — but fully CSV-aware. It operates on *rows* and *fields* rather than raw lines, correctly handling quoted fields with embedded commas, newlines, and other real-world quirks.

Written in pure Python (standard library only), it's fast to install and dependency-free.

## Key Features

* **Familiar subcommands**: `head`, `tail`, `wc`, `pick` (arbitrary row selection), `cut` (with `-x` for exclusion), `grep` (column-specific regex search with `-v` invert), `sort` (multi-key, numeric `-n`, reverse `-r`).
* **Smart header handling**: The first non-comment row is automatically treated as the header. Use `-a` (or `--add-header`) to include it in output — consistent across all subcommands.
* **Leading comment preservation**: Lines starting with `#` at the file start are treated as metadata/comments and preserved when `-a` is used (ideal for real-world exports with descriptions).
* **Delimiter autodetection**: Automatically detects common delimiters (comma, tab, pipe, semicolon, colon) — no flags needed.
* **Pipe-friendly design**: All subcommands read from stdin (or file) and output valid CSV to stdout. Complex logic (e.g., AND across fields) via simple pipelines: `csv grep pattern1 col1 | csv grep pattern2 col2`.
* **Unique tricks**: View just headers/comments with `csv head -a -0 file.csv`. Default to all fields for `sort` or `grep` when none specified.
* **POSIX-inspired syntax**: `head`/`tail` support `-N` and `+N` offsets like GNU coreutils.

## Why csv?

Traditional Unix tools break on CSVs with quotes or newlines. `csv` fixes that while keeping the muscle memory you already have.

Its niche: **quick, composable shell workflows** for inspecting, slicing, filtering, and sorting CSVs — without learning a new DSL or installing heavy suites. Perfect for scripts, debugging datasets, or handling exports with metadata comments (often discarded by other tools).

No bloat: no stats, joins, or format conversions — just reliable basics done right.

## Installation

```bash
# System-wide
sudo make install

# User-local
make install prefix=$HOME/.local
```

Requires Python 3.6+ (standard library only).

## Commands

| Command | Description |
|---------|-------------|
| `csv head [-N\|+N] [-a] [file]` | Show first N rows (default: 10). `+N` shows all but last N rows. |
| `csv tail [-N\|+N] [-a] [file]` | Show last N rows (default: 10). `+N` starts from row N. |
| `csv wc [-l] [-w] [-c] [-a] [file]` | Count rows, columns, and/or bytes. |
| `csv cut [-a] [-x] [-f file] field...` | Select (or exclude with `-x`) specific columns. |
| `csv pick [-a] [-f file] row...` | Select specific rows by number (1-indexed). |
| `csv grep [-a] [-v] [-f file] regex [field...]` | Filter rows by regex. No field = search all. |
| `csv sort [-a] [-n] [-r] [-f file] [field...]` | Sort by field(s). No field = sort by all. |

## Options

| Option | Description |
|--------|-------------|
| `-a, --add-header` | Include header row (and comments) in output |
| `-f <file>` | Specify input file (default: stdin) |
| `-x, --exclude` | Exclude fields instead of selecting (cut) |
| `-v, --invert` | Invert match (grep) |
| `-n, --numeric` | Numeric sort (sort) |
| `-r, --reverse` | Reverse/descending order (sort) |
| `-l, -w, -c` | Count rows, columns, bytes only (wc) |
| `-N` | Number of rows (head/tail) |
| `+N` | POSIX-style offset (head/tail) |

## Examples

```bash
# First 10 rows with header + comments
csv head -10 -a data.csv

# View just headers and comments (no data rows)
csv head -0 -a data.csv

# All columns except junk ones
csv cut -a -x -f data.csv password temp_id

# Filter rows where name starts with "A"
csv grep -f data.csv "^A" name

# Filter with AND (via pipe)
csv grep -f data.csv "^A" name | csv grep "York" city

# Search all fields for "error"
csv grep -f data.csv "error"

# Multi-key sort (numeric descending)
csv sort -a -n -r -f data.csv age city

# Select specific rows
csv pick -a -f data.csv 1 5 10

# Pipeline: cut columns then show first 5
csv cut -a -f data.csv name email | csv head -5 -a

# Works with tab-delimited files too
csv head -5 -a data.tsv

# Pipe-delimited? No problem
csv cut -a -f data.psv name
```

## Comparison to Other Tools

| Tool | Style | Strengths | vs. csv | Best For |
|------|-------|-----------|---------|----------|
| **csv** (this tool) | Single binary, exact POSIX subcommands | Intuitive naming, best header/comment handling, delimiter autodetect, pipeable multi-field filters, `pick` rows | Lacks pretty-printing/stats; subcommand shadowing possible | Everyday shell pipelines |
| **csvkit** | Separate tools (`csvcut`, `csvgrep`, `csvlook`) | Pretty tables, stats, conversions, SQL-like ops | More sprawl, discards comments by default | Data exploration/journalism |
| **Miller (mlr)** | Single binary, prefixed verbs (`mlr cut`) | Powerful DSL, aggregations, reshaping, multi-format, fast | Steeper curve, no direct row-index `pick` | Advanced munging/devops |
| **qsv** | Single binary, custom verbs | Blazing fast (Rust), indexing, pretty tables | Less familiar names | Large files/performance |

`csv` shines for users who love Unix tools and want CSV safety without changing habits.

## Version

1.2.0

## License

MIT License — see [COPYING](COPYING) for details.

Report bugs or contribute — issues and pull requests welcome! 🚀
