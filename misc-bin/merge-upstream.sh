#!/bin/bash

set -o nounset	# set -u
# set -o errexit	# set -e

[ $# -lt 1 ] && exit 1
[ $# -gt 2 ] && exit 1

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

function tidy_source()
{
	find . -type f -name '*.[ch]' | xargs clang-format -i
	find . -type f -name '*.[ch]' | xargs sed -i 's/ \+$//'
	find . -type f -name '*.[ch]' | xargs sed -i 's/FOREVER$/while (true)/'
}

function rename_files()
{
	[ -f crypt-gpgme.c             ] && git mv crypt-gpgme.c             crypt_gpgme.c
	[ -f crypt-gpgme.h             ] && git mv crypt-gpgme.h             crypt_gpgme.h
	[ -f crypt-mod-pgp-classic.c   ] && git mv crypt-mod-pgp-classic.c   crypt_mod_pgp_classic.c
	[ -f crypt-mod-pgp-gpgme.c     ] && git mv crypt-mod-pgp-gpgme.c     crypt_mod_pgp_gpgme.c
	[ -f crypt-mod-smime-classic.c ] && git mv crypt-mod-smime-classic.c crypt_mod_smime_classic.c
	[ -f crypt-mod-smime-gpgme.c   ] && git mv crypt-mod-smime-gpgme.c   crypt_mod_smime_gpgme.c
	[ -f crypt-mod.c               ] && git mv crypt-mod.c               crypt_mod.c
	[ -f crypt-mod.h               ] && git mv crypt-mod.h               crypt_mod.h
	[ -f doc/makedoc-defs.h        ] && git mv doc/makedoc-defs.h        doc/makedoc_defs.h
	[ -f hcache-backend.h          ] && git mv hcache-backend.h          hcache_backend.h
	[ -f hcache-bdb.c              ] && git mv hcache-bdb.c              hcache_bdb.c
	[ -f hcache-gdbm.c             ] && git mv hcache-gdbm.c             hcache_gdbm.c
	[ -f hcache-kc.c               ] && git mv hcache-kc.c               hcache_kc.c
	[ -f hcache-lmdb.c             ] && git mv hcache-lmdb.c             hcache_lmdb.c
	[ -f hcache-qdbm.c             ] && git mv hcache-qdbm.c             hcache_qdbm.c
	[ -f hcache-tc.c               ] && git mv hcache-tc.c               hcache_tc.c
}

function indent_manual()
{
	local MARKER='<!-- MIDDLE -->'
	pushd doc
	echo "$MARKER" | cat manual.xml.head - manual.xml.tail \
		| tidy -q -xml -wrap 80  \
		| sed -e 's/ \+$//' -e '/^$/d' > m.xml
	cp m.xml manual.xml.head
	mv m.xml manual.xml.tail
	sed -i "/$MARKER/,\$d" manual.xml.head
	sed -i "1,/$MARKER/d"  manual.xml.tail
	popd
}


git branch merge-0 "$LCA"
for ((i = 0; i < COUNT; i++)); do
	git branch merge-$((COUNT-i)) $LAST~$i
done

for ((i = 0; i <= COUNT; i++)); do
	git co merge-$i
	tidy_source
	rename_files
	indent_manual
	git add .
	git commit -m "clang"
done

for ((i = 0; i < COUNT; i++)); do
	git diff merge-$i merge-$((i+1)) > upstream-$((i+1)).diff
done

git checkout -b upstream master

for ((i = 1; i <= COUNT; i++)); do
	patch -p1 < upstream-$i.diff
	read -p "Check results..."
	git add .
	git commit -C ${COMMITS[COUNT-i]}
	find . -type f \( -name '*.rej' -o -name '*.orig' \) -delete
done

