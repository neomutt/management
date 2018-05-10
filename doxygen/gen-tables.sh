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
	echo " * | Config Item | Global Variable | Description |"
	echo " * | :---------- | :-------------- | :---------- |"

	for L in ${LINES[*]}; do
		if [[ "$L" =~ .*[[:space:]*](.*)[[:space:]]=[[:space:]].*\;[[:space:]]*/\*\*\<[[:space:]]Config:[[:space:]](.*)[[:space:]]\*/ ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			CFG="$(echo "$VAR" | sed -e 's/[A-Z]/_\l&/g' -e 's/^_//')"

			echo " * | '$CFG' | #$VAR | $DESC |"
		elif [[ "$L" =~ .*[[:space:]*](.*)\;[[:space:]]*/\*\*\<[[:space:]]Config:[[:space:]](.*)[[:space:]]\*/ ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			CFG="$(echo "$VAR" | sed -e 's/[A-Z]/_\l&/g' -e 's/^_//')"

			echo " * | '$CFG' | #$VAR | $DESC |"
		fi
	done

	echo " */"
	echo
}

function gen_data()
{
	local FILE="$1"
	local LINES=()

	LINES+=($(grep "^ \\* [A-Z][A-Za-z0-9_]\\+ - " "$FILE"))
	LINES+=($(grep "^[^ ].*/\\*\\*< " "$FILE" | grep -v "Config:"))

	[ ${#LINES[@]} = 0 ] && return

	echo "/**"
	grep " @page " "$FILE"
	echo " * "
	echo " * | Data | Description |"
	echo " * | :--- | :---------- |"

	(
	for L in ${LINES[*]}; do
		if [[ "$L" =~ [[:space:]*]*(.*)[[:space:]]-[[:space:]](.*) ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			echo " * | #$VAR | $DESC |"
		elif [[ "$L" =~ .*[[:space:]*]+([A-Za-z0-9_]+)[[:space:]]=[[:space:]].*\;[[:space:]]*/\*\*\<[[:space:]](.*)[[:space:]]\*/ ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			echo " * | #$VAR | $DESC |"
		elif [[ "$L" =~ .*[[:space:]*]+([A-Za-z0-9_]+)\;[[:space:]]*/\*\*\<[[:space:]](.*)[[:space:]]\*/ ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			echo " * | #$VAR | $DESC |"
		fi
	done
	) | sort

	echo " */"
	echo
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
	echo " * | Function | Description |"
	echo " * | :------- | :---------- |"

	for L in ${LINES[*]}; do
		if [[ "$L" =~ ^[[:space:]*]*((crypto*_|driver_|getdns|imap_|log_|mutt_|mx_|nntp_|pgp_|pop_|raw_|rfc1524_|smime_).*)[[:space:]]-[[:space:]](.*) ]]; then
			FUNC="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[3]}"
			echo " * | $FUNC() | $DESC |"
		elif [[ "$L" =~ ^[[:space:]*]*(edit_or_view_message|feature_enabled|is_from|log_disp_curses|main|menu_status_line|print_copyright|print_version|safe_asprintf)[[:space:]]-[[:space:]](.*) ]]; then
			FUNC="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			echo " * | $FUNC() | $DESC |"
		fi
	done

	echo " */"
	echo
}


for FILE in "$@"; do
	echo "$FILE" 1>&2
	gen_config    "$FILE"
	gen_data      "$FILE"
	gen_functions "$FILE"
done > zzz.inc

