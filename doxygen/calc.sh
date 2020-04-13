#!/bin/bash

set -e

function files()
{
	find . \( -name .git -o -name queue.h -o -name 'pgpewrap.c' -o -path './debug/*' -o -path './test/*' -o -path './autosetup/*' -o -path './docs/*' \) -prune -o -type f -name '*.[ch]' -print0 | sed -z 's/^\.\///' | sort --zero-terminated
}

[ $# = 1 ] && DIR="${1%/}" || DIR=""
HERE="$(pwd)"
# echo "DIR=$DIR"

[ -n "$DIR" ] && pushd "$DIR" >& /dev/null
files | xargs -0 ctags -R -x --c-kinds=f | awk '{print $1,$4,$3}' | column -t | sort -u > "$HERE/j1"
files | xargs -0 grep -hi "^ \+\* [a-z0-9_]\+ - " \
	| sed -e 's/.*\<\([A-Za-z0-9_]\+\) - .* - .*/\1/' -e 's/.*\<\([A-Za-z0-9_]\+\) - .*/\1/' \
	| sort -u > "$HERE/j3"
[ -n "$DIR" ] && popd >& /dev/null

awk '{print $1}' j1 | sort -u > j2
comm -2 -3 j2 j3 | sort -u > j4

ALL="$(wc -l j2 | cut -d' ' -f1)"
COM="$(wc -l j3 | cut -d' ' -f1)"
MIS=$((ALL-COM))
CPC=$((COM * 100 / ALL))

for i in $(cat j4); do
	grep -w "^$i" j1
done > j5

awk '{print $2}' j5 | sort | uniq -c | sort -nr | awk '{print $2}' > j6

for i in $(cat j6); do
	grep -Fw "$i" j5 | sort -n -k3 | awk '{print $2 ":" $3 ": " $1 }' | column -t
	echo
done > j7

awk '{print $2}' j5 | sort | uniq -c | sort -nr > j8

(
echo "All functions    $ALL"
echo "Commented        $COM ($CPC%)"
echo "Missing comments $MIS"
echo
head -n 5 j8
echo "        ..."
tail -n 5 j8
echo
) | tee j0

