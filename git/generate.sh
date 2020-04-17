#!/bin/bash

function init(){
	files=(
		"neomutt.txt"
		"mutt.txt"
	)
	mailmap_header=(
		"## NeoMutt Contributors - auto-generated: https://github.com/neomutt/management/tree/master/git"
		"## Mutt Contributors - auto-generated: https://github.com/neomutt/management/tree/master/git"
	)
}

function iterateFiles(){
	for i in "${!files[@]}"
	do
		echo "Generating $1 for ${files[i]}" 1>&2
		echo "${mailmap_header[i]}"
		generate $1 < "${files[i]}"
	done
}

function generate(){
	routine=$1
	while IFS=$'\n,' read -a ARRAY
	do
		prefix="${ARRAY[0]}"
		github_username="${ARRAY[1]}"
		pref_email="${ARRAY[2]}"
		email="${ARRAY[3]}"
		name="${ARRAY[4]}"
		preference="${ARRAY[5]}"

		# skip people without e-mail address if it's not for credits
		if [ "x$routine" != "xcredits" ]
		then
			[ "$email" == "NONE" ] && continue
		fi

		[ $prefix == "neomutt" ] && prefix="" || prefix="UPSTREAM "
		if [ "$preference" == "preferred" ]
		then
			export preferred_email="$email"
			export preferred_name="$name"
		fi

		$routine
	done | LANG=C sort -f -d
}

function mailmap-name-nick(){
		if [ -n "$github_username" ] && [ "$github_username" != "NONE" ]
		then
			printf '%s%s (@%s) <%s>\t%s <%s>\n' "$prefix" "$preferred_name" "$github_username" "$preferred_email" "$name" "$email"
		else
			printf '%s%s <%s>\t%s <%s>\n' "$prefix" "$preferred_name" "$preferred_email" "$name" "$email"
		fi
}

function mailmap-nick(){
		if [ "$prefix" == "UPSTREAM " ]
		then
			preferred_email="dev@mutt.org"
			printf '%s\t<%s>\t%s <%s>\n' "$prefix" "$preferred_email" "$name" "$email"
		else
			printf '%s\t<%s>\t%s <%s>\n' "$github_username" "$preferred_email" "$name" "$email"
		fi
}

function mailmap(){
			printf '%s <%s>\t%s <%s>\n' "$preferred_name" "$preferred_email" "$name" "$email"
}

function credits(){
	if [ "$preference" == "preferred" ]
	then
		if [ "$github_username" != "NONE" ] && [ "$github_username" != "null" ]
		then
			printf '[%s](%s "%s"),\n' "${preferred_name// / }" "https://github.com/$github_username" "$github_username"
		else
			printf '%s,\n' "${preferred_name// / }"
		fi
	fi
}

function main(){
	init
	iterateFiles mailmap-name-nick > mailmap-name-nick
	iterateFiles mailmap-nick > mailmap-nick
	iterateFiles mailmap > mailmap
	echo "Generating credits for ${files[0]}" 1>&2
	generate credits < ${files[0]} > credits
}

main
