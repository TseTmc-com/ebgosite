#!/bin/bash

FILENAME=${1:?"set file name please"}

if [ ! -f "${FILENAME}" ]
then
	echo "File not Exists"
	exit 1
fi

OUT_FOLDER="versions/"$(dirname "$FILENAME")
mkdir -p "$OUT_FOLDER"

git log --pretty=oneline --format="%ad,%H" --date=iso8601 "$FILENAME" | \
	tr " " "_" | \
	while read l
	do
		d=$(echo $l | cut -d "," -f 1)
		h=$(echo $l | cut -d "," -f 2)
		git cat-file -p "$h:$FILENAME"  > "$OUT_FOLDER/${d}.$(basename "$FILENAME")"
	done
