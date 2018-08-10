#!/bin/bash

BASE_DIR="${0%/*}"
COUNT=$(((RANDOM%20)+5))
WORDS=($(shuf -n $COUNT $BASE_DIR/fruit.txt))

mkdir -p {cur,new,tmp}

function create_email()
{
	local SECONDS="$1"
	local WORD="$2"
	local TIME="${3:-12:00:00} +0000 (GMT)"

	local DATE TIDY FILE

	DATE=$(date -d "@$SECONDS" "+%a, %d %b %Y")
	TIDY=$(date -d "@$SECONDS" "+%F")
	FILE="cur/${SECONDS}.$RANDOM:2,S"
	SUBJECT="$(shuf -n1 $BASE_DIR/animals.txt)"
	cat > "$FILE" <<-EOF
		From: $WORD <$WORD@example.com>
		To: john@example.com
		Subject: $SUBJECT
		Date: $DATE $TIME

	EOF
	lorem-ipsum-generator -p1 | fmt >> "$FILE"
}


for ((i = 2; i < $COUNT; i++)); do
	W=${WORDS[$i]}
	SECONDS=$(date -d "$i days ago" "+%s")

	create_email $SECONDS $W
done

