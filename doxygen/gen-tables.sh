#!/bin/bash

[ $# = 0 ] && exit 1

IFS=$'\n'

function gen_config()
{
	local FILE="$1"
	local LINES=()

	LINES+=($(grep "/\\*\\*< Config: " "$FILE" | sort))

	[ ${#LINES[@]} = 0 ] && return

	echo "/**"
	grep " @page " "$FILE"
	echo " *"
	echo " * | Config Item | Global Variable | Description"
	echo " * | :---------- | :-------------- | :----------"

	for L in ${LINES[*]}; do
		if [[ "$L" =~ .*[[:space:]*](.*)\;[[:space:]]*/\*\*\<[[:space:]]Config:[[:space:]](.*)[[:space:]]\*/ ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			CFG="$(echo "$VAR" | sed -e 's/[A-Z]/_\l&/g' -e 's/^_//')"

			echo " * | '$CFG' | #$VAR | $DESC |"
		fi
	done

	echo " */"
}

function gen_data()
{
	local FILE="$1"
	local LINES=()

	LINES+=($(grep "^ \\* [A-Z][A-Za-z0-9_]\\+ - " "$FILE"))
	LINES+=($(grep "/\\*\\*< " "$FILE" | grep -v "Config:"))

	[ ${#LINES[@]} = 0 ] && return

	echo "/**"
	grep " @page " "$FILE"
	echo " * "
	echo " * | Data | Description"
	echo " * | :--- | :----------"

	(
	for L in ${LINES[*]}; do
		if [[ "$L" =~ [[:space:]*]*(.*)[[:space:]]-[[:space:]](.*) ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			# echo " * | #$VAR | $DESC |"
		elif [[ "$L" =~ .*[[:space:]*]+([A-Za-z0-9_]+)\;[[:space:]]*/\*\*\<[[:space:]](.*)[[:space:]]\*/ ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			echo " * | #$VAR | $DESC |"
		fi
	done
	) | sort

	echo " */"
}

function gen_functions()
{
	local FILE="$1"
	local LINES=()

	LINES=($(grep "^ \\* [a-z0-9_]\\+ - " "$FILE" | sort))

	[ ${#LINES[@]} = 0 ] && return

	echo "/**"
	grep " @page " "$FILE"
	echo " * "
	echo " * | Function | Description"
	echo " * | :------- | :----------"

	for L in ${LINES[*]}; do
		if [[ "$L" =~ [[:space:]*]*((mutt|default)_.*)[[:space:]]-[[:space:]](.*) ]]; then
			FUNC="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[3]}"

			echo " * | $FUNC() | $DESC |"
		fi
	done

	echo " */"
}


for FILE in "$@"; do
	echo "$FILE" 1>&2
	gen_config    "$FILE"
	gen_data      "$FILE"
	gen_functions "$FILE"
done > zzz.inc

