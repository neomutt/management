#!/bin/bash

FILE="neomutt.txt"
IFS=$'\t'

grep -i "^[a-z0-9]" "$FILE" | while read NAME EMAIL NICK; do
	# Edit the name to use non-breaking space
	NBSP_NAME="${NAME// / }"
	if [ -z "$NICK" ] || [ "$NICK" = "NONE" ]; then
		echo "$NBSP_NAME,"
	else
		echo "[$NBSP_NAME](https://github.com/$NICK \"$NICK\"),"
	fi
done

