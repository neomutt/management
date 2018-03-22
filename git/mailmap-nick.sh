#!/bin/bash

SRC_NEO="neomutt.txt"
SRC_MUTT="mutt.txt"

echo '## NeoMutt Contributors'
(
	while IFS="" read -r LINE; do
		if [[ "$LINE" =~ (.*)\	(.*)\	(.*) ]]; then
			# NAME="${BASH_REMATCH[1]}"
			EMAIL="${BASH_REMATCH[2]}"
			NICK="${BASH_REMATCH[3]}"
		elif [[ "$LINE" =~ \	(.*) ]]; then
			ALT="${BASH_REMATCH[1]}"

			printf '%-15s %-37s %s\n' "$NICK" "<$EMAIL>" "$ALT"
		fi
	done < "$SRC_NEO"
) | LANG=C sort -f
echo

echo '## Mutt Contributors'
(
	while IFS="" read -r LINE; do
		if [[ "$LINE" =~ (.+)\	(.*) ]]; then
			# NAME="${BASH_REMATCH[1]}"
			# EMAIL="${BASH_REMATCH[2]}"
			:
		elif [[ "$LINE" =~ \	(.*) ]]; then
			ALT="${BASH_REMATCH[1]}"

			printf 'UPSTREAM <dev@mutt.org> %s\n' "$ALT"
		fi
	done < "$SRC_MUTT"
) | LANG=C sort -f
echo

