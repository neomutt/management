#!/bin/bash
# This script gets all commits since last release to HEAD,
# iterate through them by 250 commits bulk (github limit),
# gets authors github username, name and e-mail address,
# compare the username to contributors file by github username,
# and create list of new and regular contributors.
#
# new contributors are added to the e-mail address list, 
# the same applies for new email addresses of regular contributors.
# The e-mail address list file is sorted by github username and preference
# and replaced in the end.

function debug(){
	if [ -n "$DEBUG" ]
	then
		echo -e "$@" 1>&2
	fi
}

function help(){
	echo "$(basename $0) <path to repository> [<since_ref>] [<to_ref>]"
	echo "Set env variable DEBUG to get info about the script's run"
}

function checkdeps(){
	deps=( 'curl' 'git' 'grep' 'jq' )
	for dep in "${deps[@]}"
	do
		if ! command -v $dep >/dev/null
		then
			echo "[E] missing dependency $dep"
			ec=1
		fi
	done
	[ "x$ec" == "x1" ] && exit 1
}

function init(){
	if [ ! -d "$1" ] || [ -z "$1" ]
	then
		help
		exit 1
	fi
	export repo=$1
	export mailfile="$(dirname "$0")/neomutt_new.txt"
	export contributors_new=()
	export contributors_reg=()
	export new_to_contrib_file=()
	export last_rel=${2:-$(git --git-dir="$repo/.git" for-each-ref refs/tags --sort=-taggerdate --format='%(refname)' --count=1 | sed 's|refs/tags/||')}
	export to_rel=${3:-master}
	local commits=$(git --git-dir="$repo/.git" rev-list $last_rel..${to_rel:-master} | wc -l)
	debug "[I] There's $commits commits since last release $last_rel"
}

function getcommits(){
	debug "[I] Getting list of commits since $last_rel to HEAD"
	git --git-dir="$repo/.git" rev-list --reverse $last_rel..${to_rel:-master} | awk 'NR%250==1{print}; END{print}'
}

# read commits from stdin, call github api for each consecutive commits,
# get contributor's github username, email and name
# print uniq combination to stdout
function iteratecommits(){
	while read cur
	do
		if [ ! -z $last ]
		then
			debug "[I] Getting commits from GitHub API $last .. $cur"
			curl -Ns "https://api.github.com/repos/neomutt/neomutt/compare/$last...$cur" \
				| jq -j '.commits[] | select(.commit.message|test("Upstream-commit:")|not) | .author.login,",",.commit.author.email,",",.commit.author.name,"\n"'
			local last=$cur
		else
			local last=$cur
			continue
		fi	
	done | sort -u
}

function printcontribs(){
	for i in "$@"
	do
		echo "- $i"
	done
	echo
}

function contribs(){
	echo "## :heart: Thanks"
	echo
	if [ ${#contributors_new[@]} -gt 0 ]
	then
		echo "Many thanks to our **new contributors**:"
		printcontribs "${contributors_new[@]}"
		regular_message="and our **regular contributors**:"
	fi

	if [ ${#contributors_reg[@]} -gt 0 ]
	then
		
		echo "${regular_message:-Many thanks to our **regular contributors**:}"
		printcontribs "${contributors_reg[@]}"
	fi
}

function record_new(){
	local tempfile=$(mktemp)
	{
		cat "$mailfile"
		printf '%s\n' "${new_to_contrib_file[@]}"
		printf '%s\n' "${reg_to_contrib_file[@]}"
	} | grep -v '^$' | LANG=C sort -u -t',' -k 3,4 -k4,5 -k6 | sort -k2,3 -k6,6 -t ',' > $tempfile
	mv $tempfile "$mailfile"
}


function getcontribs(){
	while IFS=$'\n,' read github_username email name
	do
		if ! grep -iq "^neomutt,$github_username" "$mailfile"
		then
			contributors_new+=( "$name (@$github_username)" )
			new_to_contrib_file+=( "neomutt,$github_username,$email,$email,$name,preferred" )
			debug "[I] Adding a new contributor @$github_username - $name <$email> to the $mailfile."
		else
			contributors_reg+=( "$name (@$github_username)" )
			if ! grep -q ",$email,$name"  "$mailfile"
			then
				
				pref_email=$(grep ",$email,$name"  "$mailfile" | cut -f 3)
				reg_to_contrib_file+=( "neomutt,$github_username,$pref_email,$email,$name,secondary" )
				debug "[I] Adding a new e-mail address <$email> of @$github_username - $name to the $mailfile."
			fi

		fi
	done
	contribs
	record_new
}

issues(){
	last_rel_date=$(git --git-dir="$repo/.git"  log -1 --format=%aI $last_rel)
	issues=$(curl -Ns "https://api.github.com/repos/neomutt/neomutt/issues?state=closed&since=${last_rel_date}")

	echo "# this is just an example." 

	echo
	echo "## :beetle: Bug Fixes"
	jq -j '.[]| select( .labels[].name | contains("bug"))|"- ",.title,"\n"' <<<"$issues" | sort -u

	echo
	echo "## :black_flag: Translations"
	echo " - how to get the stats?"

	echo
	echo "## :gift: Features" # assuming featurs are not bug fixes or changed configs
	jq -j '.[]| select( .labels[].name | (contains("bug") or contains("config-file"))|not)|"- ",.title,"\n"' <<<"$issues" | sort -u

	echo
	echo "## :wrench: Changed Config"
	jq -j '.[]| select( .labels[].name | contains("config-file"))|"- ",.title,"\n"' <<<"$issues"
}

function main(){
	checkdeps
	init "$@"
	getcommits | iteratecommits | getcontribs
	issues
}

main "$@"
