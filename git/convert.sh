#!/usr/bin/env bash
# this script is one time, one purpose to convert mailmap files
# from following format:
# NAME SURNAME	email@exmaple.com	github_username
#	NAME SURNAME <email@example.com>
#
# To a new format:
# prefix,github_username,email,name surename,preference
# where fields are following:
#   prefix          – whether contributor is neomutt or neomutt contributor
#   github_username – contributor's github username
#   name surename   – contributor's name
#   email           – contributor's email address
#   preference      – preferred or secondary contact
#
# Because mailmap file can contain both mutt and neomutt users now the script
# needs to be run on only neomutt or mutt portion of the file. After that the
# result is supposed to be concatenated.
# -----------------------------------------------------------------------------
# HOW THIS SCRIPT WORKS??
# `tr` to remove closing angle brackets after email addresses
#
# `sed` to replace opening angle brackets infront email address and make the whole file TSV 
#
# 1st awk
# -v prefix="$2" # set prefix (it's supposed to be "mutt" or "neomutt") to  second argument of the script
# -F – the file separator is TAB
# /^\s*%/ {next;} – skip to next line if empty
# OFS="," – set output to be comma separated
# if ($1 != "")  – matches lines with preferred email addreses
# set variables – some of them may be overwritten by else branch
# in next iteation.
# else if($1=="") – matches the lines of secondary contacts
# set some variables we need or rewrite them from preferred
# print the line in CSV
#
# 2nd awk
# just for deduplication. skip deduplication where email == NONE

if [ $# -ne 2 ] || [ "x$1" == "x-h" ] || [ "x$1" == "x--help" ]
then
	echo 1>&2 "$0 usage:"
	echo 1>&2 "$0 mailmap <mutt|neomutt>"
	echo 1>&2 "first argument - mailmap files is or mutt or neomutt part only"
	echo 1>&2 "second argument - tells how to prefix entries for new mailmap file"
	exit 1
fi

tr -d '>' < $1 \
	| sed 's/ </	/' \
	| awk -v prefix="$2" -F '[\t]' \
		'/^\s*$/{next}
		OFS=","
	 	{
		if($1 != ""){
			preference="preferred"
			name=$1
			pref_name=$1
			pref_email=$2
			email=$2
			gh=$3
		} else if($1==""){
			if ($2==pref_name && $3==pref_email){ next;}
			preference="secondary"
			name=$2
			email=$3
		}}{print prefix,gh,pref_email,email,name,preference}'\
			| grep -v '\t' \
			|sort -k 2,3 -k6,6 -t ','
