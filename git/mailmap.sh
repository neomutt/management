#!/bin/bash

SRC_NEO="neomutt.txt"
SRC_MUTT="mutt.txt"

echo '## NeoMutt Contributors'
(
	while IFS="" read -r LINE; do
		if [[ "$LINE" =~ (.*)\	(.*)\	(.*) ]]; then
			NAME="${BASH_REMATCH[1]}"
			EMAIL="${BASH_REMATCH[2]}"
			NICK="${BASH_REMATCH[3]}"

			PERSON="$NAME <$EMAIL>"
		elif [[ "$LINE" =~ \	(.*) ]]; then
			ALT="${BASH_REMATCH[1]}"

			if [ "$NICK" = "NONE" ]; then
				printf '%-63s %-56s #\n' "$PERSON" "$ALT"
			else
				printf '%-63s %-56s # @%s\n' "$PERSON" "$ALT" "$NICK"
			fi
		fi
	done < "$SRC_NEO"
) | LANG=C sort -f
echo

echo '## Mutt Contributors'
(
	while IFS="" read -r LINE; do
		if [[ "$LINE" =~ (.+)\	(.*) ]]; then
			NAME="${BASH_REMATCH[1]}"
			EMAIL="${BASH_REMATCH[2]}"

			PERSON="$NAME <$EMAIL>"
		elif [[ "$LINE" =~ \	(.*) ]]; then
			ALT="${BASH_REMATCH[1]}"

			printf '%-63s %s\n' "$PERSON" "$ALT"
		fi
	done < "$SRC_MUTT"
) | LANG=C sort -f
echo

