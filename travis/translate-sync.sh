#!/bin/bash

set -o errexit # set -e
set -o nounset # set -u

SCRIPT_DIR="${0%/*}"

function usage()
{
	echo "${0##*/} [diff|copy] DIR"
	echo "    copy: copy files to HERE"
	echo "    diff: diff files assuming HERE is newer"
	exit 1
}


MGMT=(
	"translate/travis.yml"
	"translate/deploy.sh"
	"translate/generate-webpage.sh"
	"translate/prep.sh"
	"translate/stats.sh"
	"translate/travis-deploy-github.enc"
)

CODE=(
	".travis.yml"
	".travis/deploy.sh"
	".travis/generate-webpage.sh"
	".travis/prep.sh"
	".travis/stats.sh"
	".travis/travis-deploy-github.enc"
)


MODE="diff"
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

if [ $# -gt 0 ]; then
	OTHER_DIR="${1%/}"
else
	if [ -f "${MGMT[0]}" ]; then
		usage
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

if [ -f "${MGMT[0]}" ]; then
	FIRST="$OTHER_DIR"
	LOCAL=("${MGMT[@]}")
	REMOTE=("${CODE[@]}")
else
	FIRST="$SCRIPT_DIR"
	LOCAL=("${CODE[@]}")
	REMOTE=("${MGMT[@]}")
fi

COUNT="${#MGMT[@]}"
for ((i = 0; i < COUNT; i++)); do
	if [ "$MODE" = "diff" ]; then
		diff --unified --color=auto "$FIRST/${REMOTE[i]}" "${LOCAL[i]}" || true
	else
		cp -v "$FIRST/${REMOTE[i]}" "${LOCAL[i]}"
	fi
done

