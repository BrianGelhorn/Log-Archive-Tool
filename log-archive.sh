#!/bin/bash

FILEDIR=""
LOGDIRECTORY="./logArchives"
while [[ "$#" -gt 0  ]]; do
	case "$1" in
		--help|-h)
			#TODO show help
			exit 0
			;;
		*)
			FILEDIR="$1"
			shift
			;;
	esac
done

#If specified file in arguments doesn´t exist, we show error
if ! [[ -d "$FILEDIR" ]]; then
	echo "The specified directory $FILERDIR doesn´t exist"
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

