#!/bin/bash

# set -o errexit	# set -e
# set -o nounset	# set -u

IFS=$'\n'
LANG=C

function zzz_config()
{
	local FILE="$1"
	local LINES=()

	LINES+=($(LANG=C grep "/\\*\\*< Config: " "$FILE" | sort))

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
			CFG="$(echo "$VAR" | sed -e 's/\<C_//' -e 's/8bit/_&/' -e 's/\(Tlsv1\)\([0-9]\)/\1_\2/' -e 's/[A-Z]/_\l&/g' -e 's/^_//')"

			echo " * | '$CFG' | #$VAR | $DESC |"
		elif [[ "$L" =~ .*[[:space:]*](.*)\;[[:space:]]*/\*\*\<[[:space:]]Config:[[:space:]](.*)[[:space:]]\*/ ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			CFG="$(echo "$VAR" | sed -e 's/\<C_//' -e 's/8bit/_&/' -e 's/\(Tlsv1\)\([0-9]\)/\1_\2/' -e 's/[A-Z]/_\l&/g' -e 's/^_//')"

			echo " * | '$CFG' | #$VAR | $DESC |"
		fi
	done

	echo " */"
	echo
}

function zzz_config_summary()
{
	local FILES="$*"
	local LINES=()

	LINES+=($(grep "///< Config: " $FILES))
	[ ${#LINES[@]} = 0 ] && return

	echo "/**"
	echo " * @page config_vars Neomutt's Configuration variables"
	echo " *"
	echo " * Brief overview of all of Neomutt's Configuration variables."
	echo " *"
	echo " * | Global Variable | Config Item | Description |"
	echo " * | :-------------- | :---------- | :---------- |"

	(
	for L in ${LINES[*]}; do
		if [[ "$L" =~ .*[[:space:]*](.*)[[:space:]]=[[:space:]].*\;[[:space:]]*///\<[[:space:]]Config:[[:space:]](.*) ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			CFG="$(echo "$VAR" | sed -e 's/\<C_//' -e 's/8bit/_&/' -e 's/\(Tlsv1\)\([0-9]\)/\1_\2/' -e 's/[A-Z]/_\l&/g' -e 's/^_//')"

			echo " * | #$VAR | \$$CFG | $DESC |"
		elif [[ "$L" =~ .*[[:space:]*](.*)\;[[:space:]]*///\<[[:space:]]Config:[[:space:]](.*) ]]; then
			VAR="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			CFG="$(echo "$VAR" | sed -e 's/\<C_//' -e 's/8bit/_&/' -e 's/\(Tlsv1\)\([0-9]\)/\1_\2/' -e 's/[A-Z]/_\l&/g' -e 's/^_//')"

			echo " * | #$VAR | \$$CFG | $DESC |"
		else
			echo "UNKNOWN:: $L"
		fi
	done
	) | sort

	echo " */"
	echo
}

function zzz_data()
{
	local FILE="$1"
	local LINES=()

	LINES+=($(LANG=C grep "^ \\* [A-Z][A-Za-z0-9_]\\+ - " "$FILE"))
	LINES+=($(LANG=C grep "^[^ ].*/\\*\\*< " "$FILE" | grep -v "Config:"))

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

function zzz_functions()
{
	local FILE="$1"
	local LINES=()

	LINES=($(LANG=C grep "^ \\* [a-z0-9_]\\+ - " "$FILE" | LANG=C sort))

	[ ${#LINES[@]} = 0 ] && return

	echo "/**"
	grep " @page " "$FILE"
	echo " * "
	echo " * | Function | Description |"
	echo " * | :------- | :---------- |"

	for L in ${LINES[*]}; do
		if [[ "$L" =~ ^[[:space:]*]*((address|bool|command|crypto*_|cs|driver_|dump|getdns|hcache|imap_|log_|long|magic|mbox_|mbtable|mmdf_|mutt_|mx_|nm_|nntp_|number|path|pgp_|pop_|quad|raw_|regex|rfc1524_|rfc2047_|rfc2231_|serial_|smime_|sort|string|tunnel_|url).*)[[:space:]]-[[:space:]](.*[[:space:]]-[[:space:]].*) ]]; then
			FUNC="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[3]}"
			echo " * | $FUNC() | $DESC |"
		elif [[ "$L" =~ ^[[:space:]*]*(.*_validator)[[:space:]]-[[:space:]](.*[[:space:]]-[[:space:]].*) ]]; then
			FUNC="${BASH_REMATCH[1]}"
			DESC="${BASH_REMATCH[2]}"
			echo " * | $FUNC() | $DESC |"
		elif [[ "$L" =~ ^[[:space:]*]*((account|address|attach|bool|ci|command|crypto*_|cs|driver_|dump|getdns|hcache|imap_|km|log_|long|magic|mbox_|mbtable|menu|mix|mmdf_|mutt_|mx_|myvar|nm_|nntp_|number|path|pgp_|pop_|quad|raw_|regex|rfc1524_|rfc2047_|rfc2231_|rfc3676|serial_|smime_|sort|state|string|text|tunnel_|update|url|wcs).*)[[:space:]]-[[:space:]](.*) ]]; then
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

function build_zzz()
{
	local FILE

	for FILE in $@; do
		echo "$FILE" 1>&2
		zzz_config    "$FILE"
		zzz_data      "$FILE"
		zzz_functions "$FILE"
	done
}

function git_version()
{
	git describe --abbrev=6 --match "neomutt-*" $(git merge-base master HEAD) |
		sed 's/neomutt-\(....\)\(..\)\(..\)-\([0-9]\+\)-g\([0-9a-f]\+\)/\1-\2-\3 +\4-\5/'
}

function build_docs()
{
	VERSION=$(git_version)

	(
		cat doxygen/doxygen.conf
		echo "HAVE_DOT=yes"
		echo "PROJECT_NUMBER=\"$VERSION\""
	) | doxygen -

	grep -v "Consider increasing DOT_GRAPH_MAX_NODES" doxygen-build.txt | tee tmp.txt
	test ! -s tmp.txt
}

if [ -n "$TRAVIS" ]; then
	git fetch --unshallow --tags
	git fetch origin 'refs/heads/master:refs/heads/master'
fi

build_zzz \
	address/*.c \
	config/*.c \
	conn/*.c \
	email/*.c \
	hcache/*.c \
	hcache/hcache.h \
	imap/*.c \
	maildir/*.c \
	mbox/*.c \
	mutt/*.c \
	ncrypt/*.c \
	nntp/*.c \
	notmuch/*.c \
	pop/*.c \
	*.c > zzz.inc

zzz_config_summary *.[ch] {address,config,conn,email,hcache,imap,maildir,mbox,mutt,ncrypt,nntp,notmuch,pop}/*.[ch] \
	| grep -v -e SslUseSslv2 -e SslUsesystemcerts >> zzz.inc

build_docs

