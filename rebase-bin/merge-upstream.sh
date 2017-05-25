#!/bin/bash

set -o nounset	# set -u
# set -o errexit	# set -e

[ $# -lt 1 ] && exit 1
[ $# -gt 2 ] && exit 1

BASE_DIR="${0%/*}"

source "$BASE_DIR/common.sh"

FIRST="$1"
LAST="${2:-$FIRST}"

FIRST="$(git rev-parse "$FIRST")" || exit 1
LAST="$(git rev-parse "$LAST")"   || exit 1
LCA="$(git rev-parse "$FIRST^")"  || exit 1

COMMITS=($(git rev-list --abbrev-commit $LCA..$LAST))
COUNT=${#COMMITS[@]}

# echo "FIRST   $FIRST"
# echo "LAST    $LAST"
echo "COMMITS ${COMMITS[@]}"
echo "COUNT   $COUNT"
echo "LCA     $LCA"
echo
git log --reverse --oneline $LCA..$LAST | nl
echo

git branch merge-0 "$LCA"
for ((i = 0; i < COUNT; i++)); do
	git branch merge-$((COUNT-i)) $LAST~$i
done

for ((i = 0; i <= COUNT; i++)); do
	git co merge-$i
	remove_files
	remove_underscores
	rename_files
	tidy_source
	indent_manual
	git add .
	git commit -m "sync source"
done

for ((i = 0; i < COUNT; i++)); do
	git diff merge-$i merge-$((i+1)) > upstream-$((i+1)).diff
done

git checkout -b upstream master

for ((i = 1; i <= COUNT; i++)); do
	echo "-------------------------------------------------------------------------------"
	git log --oneline -n 1 ${COMMITS[COUNT-i]}
	echo
	patch -p1 < upstream-$i.diff
	read -p "Check results..."
	git add .
	git commit -C ${COMMITS[COUNT-i]}
	find . -type f \( -name '*.rej' -o -name '*.orig' \) -delete
done

