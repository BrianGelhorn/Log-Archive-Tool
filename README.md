# Log Archive Tool

This script compresses the specified log directory into a .tar.gz archive and saves it in a directory.

## Features

- Archives any log directory passed as an argument
- Generates timestamped archive names

## Requirements

- Linux
- Bash
- `tar`
- `date`
- `awk`

## Usage
```bash
./log-archive.sh [OPTIONS] DIRECTORY
```

## Examples

Archive the `/var/log/sysstat` directory

`./log-archive.sh /var/log/sysstat`

The output should look like:

```bash
The log logs_archive_20260402_124729 was created succesfully
```

## Autor
Developed by Brian Gelhorn. Project made for Roadmap.sh https://roadmap.sh/projects/log-archive-tool

## License
This project is intended for educational and practice purposes.# Log-Archive-Tool
