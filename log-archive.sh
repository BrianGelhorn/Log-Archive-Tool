#!/bin/bash

show_help() {
cat << 'EOF'
log-archive.sh - Compress a log directory into a timestamped .tar.gz archive

USAGE:
  ./log-archive.sh [OPTIONS] DIRECTORY

DESCRIPTION:
  This script compresses the specified log directory into a .tar.gz archive.
  Archives are stored in the default output directory: ./logArchives

OPTIONS:
  -h, --help
      Show this help message and exit.

OUTPUT:
  The archive is saved inside:
      ./logArchives

  Archive name format:
      logs_archive_YYYYMMDD_HHMMSS.tar.gz

EXAMPLES:
  ./log-archive.sh /var/log
      Archive the /var/log directory.

  ./log-archive.sh ./mylogs
      Archive the ./mylogs directory.

NOTES:
  - The output directory is created automatically if it does not exist.
EOF
}

FILEDIR=""
LOGDIRECTORY="./logArchives"

if [[ "$#" == 0 ]]; then
	echo "No arguments were specified"
	exit 1
fi

while [[ "$#" -gt 0  ]]; do
	case "$1" in
		--help|-h)
			show_help
			exit 0
			;;
		-*)
			echo "The specified argument doesn´t exist."
			exit 1
			;;
		*)
			FILEDIR="$1"
			shift
			;;
	esac
done

#If specified file in arguments doesn´t exist, we show error
if ! [[ -d "$FILEDIR" ]]; then
	echo "The specified directory $FILEDIR doesn´t exist"
	exit 1
fi

#If the folder that contains the logs doesn´t exist, we create it
if ! [[ -d "$LOGDIRECTORY" ]]; then
	mkdir logArchives
fi

TIMESTAMPS="$(date +"%Y%m%d %H%M%S")"
FILENAME="logs_archive_$(echo $TIMESTAMPS | awk '{ print $1 }')_$(echo $TIMESTAMPS | awk '{ print $2 }')"
#Delete the first /
FILEDIR="${FILEDIR#/}"
#Compress and change the parent directory to the root directory so we use relative paths and we avoid problems of absolut pathing being compressed at the tar
tar -czf "$LOGDIRECTORY/$FILENAME.tar.gz" -C / "$FILEDIR"
if [[ "$?" == 0 ]]; then
	echo "The log $FILENAME was created succesfully"
	exit 0
else
	echo "ERROR: Failed to create the archive" >&2
	exit 1
fi
