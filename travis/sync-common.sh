#!/bin/bash

function sync_usage()
{
	echo "${0##*/} [diff|copy] DIR"
	echo "    copy: copy files to HERE"
	echo "    diff: diff files assuming HERE is newer"
	exit 1
}

function sync_perform()
{
	local MODE="diff"
	if [ $# -gt 0 ]; then
		case "$1" in
			d|diff)
				MODE="diff"
				shift
				;;
			c|copy)
				MODE="copy"
				shift
				;;
		esac
	fi

	local OTHER_DIR
	if [ $# -gt 0 ]; then
		OTHER_DIR="${1%/}"
	else
		if [ -f "${MGMT[0]}" ]; then
			sync_usage
		elif [ -f "${CODE[0]}" ]; then
			OTHER_DIR="$SCRIPT_DIR"
		else
			echo "I don't know where I am"
			exit 1
		fi
	fi

	if [ ! -d "$OTHER_DIR" ]; then
		echo "Not a directory: $OTHER_DIR"
		exit 1
	fi

	local FIRST
	local LOCAL
	local REMOTE
	if [ -f "${MGMT[0]}" ]; then
		FIRST="$OTHER_DIR"
		LOCAL=("${MGMT[@]}")
		REMOTE=("${CODE[@]}")
	else
		FIRST="$SCRIPT_DIR"
		LOCAL=("${CODE[@]}")
		REMOTE=("${MGMT[@]}")
	fi

	local COUNT="${#MGMT[@]}"
	for ((i = 0; i < COUNT; i++)); do
		if [ "$MODE" = "diff" ]; then
			diff --unified --color=auto "$FIRST/${REMOTE[i]}" "${LOCAL[i]}" || true
		else
			cp -Lv "$FIRST/${REMOTE[i]}" "${LOCAL[i]}"
		fi
	done
}
