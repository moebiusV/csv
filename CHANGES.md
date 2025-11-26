# CSV Tool - Change Summary

## Final Behavior

The CSV tool now works with the following behavior:

### Commands Available
- **head** - Show first n rows of CSV file(s)
- **tail** - Show last n rows of CSV file(s)
- **wc** - Count rows, columns, and bytes in CSV file(s)

### Default Behavior
- **Does NOT include header by default** (head/tail) - only shows data rows
- **Defaults to 10 rows** when no number is specified (head/tail)
- Use `-a` or `--add-header` flag to include the header row (head/tail)
- **Supports multiple files** - process multiple CSV files in one command
- **Options must come before filenames** - once a filename is encountered, all remaining arguments are treated as filenames

### Syntax
```bash
csv head [number] [-a] <file> [file ...]
csv tail [number] [-a] <file> [file ...]
csv wc [-l] [-w] [-c] <file> [file ...]
```

### WC Options
The `wc` command supports the following options (same as Unix wc):
- `-l`: Count rows only (equivalent to lines in Unix wc)
- `-w`: Count columns only (equivalent to words in Unix wc)
- `-c`: Count bytes only
- Combine options: `-lw`, `-lc`, `-wc`, `-lwc`
- Default (no options): show all three (rows, columns, bytes)

### Examples

**Single file without header (default):**
```bash
csv head myfile.csv          # First 10 data rows
csv head -1 myfile.csv       # First data row
csv tail -5 myfile.csv       # Last 5 data rows
```

**Single file with header (using -a flag BEFORE filename):**
```bash
csv head -a myfile.csv       # Header + first 10 data rows
csv head -1 -a myfile.csv    # Header + first data row
csv tail -5 -a myfile.csv    # Header + last 5 data rows
```

**Multiple files:**
```bash
csv head file1.csv file2.csv file3.csv           # First 10 rows of each
csv head -5 -a file1.csv file2.csv               # First 5 rows with header of each
csv tail -2 data1.csv data2.csv data3.csv        # Last 2 rows of each
```

**Word count (wc):**
```bash
csv wc myfile.csv                                # Count rows, columns, bytes (all)
csv wc -l myfile.csv                             # Count rows only
csv wc -w myfile.csv                             # Count columns only
csv wc -c myfile.csv                             # Count bytes only
csv wc -lw myfile.csv                            # Count rows and columns
csv wc file1.csv file2.csv file3.csv             # Count multiple files with totals
csv wc -l file1.csv file2.csv                    # Count rows for multiple files
```

Output format for wc:
```
# Default (all three):
    rows  columns    bytes filename
      11        4      357 myfile.csv

# With -l only:
    rows filename
      11 myfile.csv

# With -w only:
 columns filename
       4 myfile.csv

# With -c only:
   bytes filename
     357 myfile.csv

# With -lw:
    rows  columns filename
      11        4 myfile.csv
```

**IMPORTANT - Option placement:**
```bash
# ✅ CORRECT: -a before filename
csv head -1 -a myfile.csv

# ❌ INCORRECT: -a after filename (will try to open file named "-a")
csv head -1 myfile.csv -a
```

### Changes Made
1. ✅ Inverted default behavior: no header by default (previously included header)
2. ✅ Changed flag from `--no-header` to `-a`/`--add-header`
3. ✅ Already had default of 10 rows when number not specified
4. ✅ Added support for multiple files
5. ✅ Enforced option placement before filenames (Unix-style)
6. ✅ Properly handles CSV rows with embedded newlines and commas
7. ✅ `-h` still works for help, `-a` adds header
8. ✅ Added `wc` command for CSV-aware counting (rows, columns, bytes)

### WC Command Details
The `wc` command provides CSV-aware counting with Unix-compatible options:
- **-l**: Rows (total number of rows including header, properly handling quoted newlines)
- **-w**: Columns (number of columns/fields per row)
- **-c**: Bytes (file size in bytes, same as Unix wc)
- **Combine options**: Use `-lw`, `-lc`, `-wc`, or `-lwc` to show specific combinations
- **Default**: If no options specified, shows all three (equivalent to `-lwc`)
- **Totals**: When multiple files are provided, shows grand totals

### Multiple File Behavior
- When processing multiple files, each file's output is labeled with `==> filename <==`
- A blank line separates the output from different files
- When processing a single file, no filename label is shown
- The `wc` command shows totals when counting multiple files

### Help
```bash
csv --help     # Show usage information
```
