# CSV Head/Tail/WC Tool

A Python script that implements Unix-style `head`, `tail`, and `wc` commands for CSV files, operating on a row basis rather than a line basis. This properly handles CSV files with quoted fields that may contain newlines.

## Installation

1. Download the `csv` script
2. Make it executable:
   ```bash
   chmod +x csv
   ```
3. Optionally, move it to a directory in your PATH:
   ```bash
   sudo mv csv /usr/local/bin/
   ```

## Usage

```bash
csv head [number] [-a] <file> [file ...]    # Show first n rows (default: 10, no header by default)
csv tail [number] [-a] <file> [file ...]    # Show last n rows (default: 10, no header by default)
csv wc [-l] [-w] [-c] <file> [file ...]     # Count rows, columns, and/or bytes
```

### Options

**For head/tail:**
- `number`: Number of rows to display (optional, default: 10)
- `-a` or `--add-header`: Include header row in output (optional)

**For wc:**
- `-l`: Count rows only
- `-w`: Count columns only  
- `-c`: Count bytes only
- Combine options (e.g., `-lw`, `-lwc`)
- Default (no options): show all three (rows, columns, bytes)

**Important:** Options must come before any filenames. Once a filename is encountered, all remaining arguments are treated as filenames.

## Examples

### Head and Tail

```bash
# Show the first 10 data rows (default, no header)
csv head myfile.csv

# Show the first data row (no header)
csv head -1 myfile.csv

# Show the first 10 data rows (no header)
csv head -10 myfile.csv

# Show the last 10 data rows (default, no header)
csv tail myfile.csv

# Show the last data row (no header)
csv tail -1 myfile.csv

# Show the last 5 data rows (no header)
csv tail -5 myfile.csv

# Show the first data row (with header) - note -a comes BEFORE filename
csv head -1 -a myfile.csv

# Show the last 3 data rows (with header)
csv tail -3 -a myfile.csv

# Show the first 10 rows (with header)
csv head -a myfile.csv

# Multiple files - shows first 5 rows of each
csv head -5 file1.csv file2.csv file3.csv

# Multiple files with header
csv head -5 -a file1.csv file2.csv

# INCORRECT: -a after filename is treated as a filename, not an option
# csv head myfile.csv -a   # This will try to open a file named "-a"
```

### WC (Word Count for CSV)

```bash
# Count rows, columns, and bytes (default - all three)
csv wc myfile.csv
# Output format: rows columns bytes filename
#       11       4     357 myfile.csv

# Count only rows (-l)
csv wc -l myfile.csv
#       11 myfile.csv

# Count only columns (-w for "words")
csv wc -w myfile.csv
#        4 myfile.csv

# Count only bytes (-c)
csv wc -c myfile.csv
#      357 myfile.csv

# Count rows and columns (-lw)
csv wc -lw myfile.csv
#       11       4 myfile.csv

# Count rows and bytes (-lc)
csv wc -lc myfile.csv
#       11     357 myfile.csv

# Count all three explicitly (-lwc, same as default)
csv wc -lwc myfile.csv
#       11       4     357 myfile.csv

# Count for multiple files (shows totals)
csv wc file1.csv file2.csv file3.csv
#       11       4     357 file1.csv
#        4       3      68 file2.csv
#       50       5    2100 file3.csv
#       65      12    2525 total

# Count only rows for multiple files
csv wc -l file1.csv file2.csv
#       11 file1.csv
#        4 file2.csv
#       15 total
```

## Features

- **Row-aware parsing**: Uses Python's CSV parser to properly handle:
  - Quoted fields with commas
  - Quoted fields with newlines
  - Various CSV dialects
  
- **Header control**: By default excludes the CSV header row from output. Use `-a` or `--add-header` to include it.

- **Multiple file support**: Process multiple CSV files in a single command. When multiple files are specified, each file's output is labeled with its filename.

- **CSV-aware counting**: The `wc` command counts:
  - **Rows** (-l) instead of lines (properly handling quoted fields with newlines)
  - **Columns** (-w) instead of words (number of fields per row)
  - **Bytes** (-c) same as Unix wc
  - Supports combining options: `-lw`, `-lc`, `-wc`, `-lwc`
  - Default behavior (no options): shows all three
  - Shows totals when counting multiple files

- **Option placement**: Options must come before filenames. Once a filename is encountered, all remaining arguments are treated as filenames, matching standard Unix behavior.

- **Unix-style syntax**: Familiar command-line interface similar to standard `head`, `tail`, and `wc`

## How it differs from Unix head/tail/wc

Standard Unix `head` and `tail` work on a line-by-line basis, which can break CSV files:
- A CSV field with a newline in quotes would be treated as multiple lines
- You'd need to manually skip or include the header row

Standard Unix `wc` counts lines, words, and bytes:
- Lines would be incorrect for CSV files with quoted newlines
- Words are not meaningful for CSV data

This tool treats each CSV row as a unit, regardless of internal newlines:
- **head/tail**: By default excludes the header row (showing only data rows), but you can include it with the `-a` flag
- **wc**: Counts rows (not lines), columns (not words), and bytes, giving you meaningful statistics for CSV files

## Requirements

- Python 3.6+
- No external dependencies (uses only standard library)
