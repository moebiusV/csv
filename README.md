# csv - Unix-style CSV Processor

**csv** is a lightweight, single-binary command-line tool that brings familiar Unix classics like `head`, `tail`, `wc`, `cut`, `grep`, and `sort` to CSV files — but fully CSV-aware. It operates on *rows* and *fields* rather than raw lines, correctly handling quoted fields with embedded commas, newlines, and other real-world quirks.

Written in pure Python (standard library only), it's fast to install and dependency-free.

## Key Features

- **Familiar subcommands**: `head`, `tail`, `wc`, `pick` (arbitrary row selection), `cut` (with `-x` for exclusion), `grep` (column-specific regex search with `-v` invert), `sort` (multi-key, numeric `-n`, reverse `-r`).
- **Smart header handling**: The first non-comment row is automatically treated as the header. Use `-a` (or `--add-header`) to include it in output — consistent across all subcommands.
- **Leading comment preservation**: Lines starting with `#` at the file start are treated as metadata/comments and preserved when `-a` is used (ideal for real-world exports with descriptions).
- **Delimiter autodetection**: Automatically detects common delimiters (comma, tab, pipe, etc.) — no flags needed.
- **Pipe-friendly design**: All subcommands read from stdin (or file) and output valid CSV to stdout. Complex logic (e.g., AND across fields) via simple pipelines: `csv grep pattern1 col1 | csv grep pattern2 col2`.
- **Unique tricks**: View just headers/comments with `csv head -a -1 file.csv`. Default to all fields for `sort` or `grep` when none specified.
- **POSIX-inspired syntax**: `head`/`tail` support `-N` and `+N` offsets like GNU coreutils.

## Why csv?

Traditional Unix tools break on CSVs with quotes or newlines. `csv` fixes that while keeping the muscle memory you already have.

Its niche: **quick, composable shell workflows** for inspecting, slicing, filtering, and sorting CSVs — without learning a new DSL or installing heavy suites. Perfect for scripts, debugging datasets, or handling exports with metadata comments (often discarded by other tools).

No bloat: no stats, joins, or format conversions — just reliable basics done right.

## Comparison to Other Tools

| Tool       | Style                                | Strengths                                      | vs. csv                                                | Best For                          |
|------------|--------------------------------------|------------------------------------------------|--------------------------------------------------------|-----------------------------------|
| **csv** (this tool) | Single binary, exact POSIX subcommands | Intuitive naming, best header/comment handling, delimiter autodetect, pipeable multi-field filters, `pick` rows | Lacks pretty-printing/stats; subcommand shadowing possible | Everyday shell pipelines          |
| **csvkit** | Separate tools (`csvcut`, `csvgrep`, `csvlook`) | Pretty tables, stats, conversions, SQL-like ops | More sprawl, discards comments by default             | Data exploration/journalism       |
| **Miller (mlr)** | Single binary, prefixed verbs (`mlr cut`) | Powerful DSL, aggregations, reshaping, multi-format, fast | Steeper curve, no direct row-index `pick`              | Advanced munging/devops           |
| **qsv**    | Single binary, custom verbs          | Blazing fast (Rust), indexing, pretty tables   | Less familiar names                                    | Large files/performance           |

`csv` shines for users who love Unix tools and want CSV safety without changing habits.

## Installation

```bash
# System-wide
sudo make install

# User-local
make install prefix=$HOME/.local
```

Requires Python 3.6+ (standard library only).

## Examples

```bash
# First 10 rows with header + comments
csv head -10 -a data.csv

# All columns except junk ones
csv cut -a -x password temp_id data.csv

# Filter with AND (via pipe)
csv grep "^A" name data.csv | csv grep "York" city

# Multi-key sort (numeric descending)
csv sort -a -n -r age city data.csv

# Search all fields
csv grep "error"

# Pipeline: cut then head
csv cut -a name email data.csv | csv head -5 -a

# View just headers/comments
csv head -a -1 data.csv
```

## License

MIT License — see [COPYING](COPYING) for details.

Report bugs or contribute — issues and pull requests welcome! 🚀
