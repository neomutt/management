#!/bin/bash

set -o nounset	# set -u
# set -o errexit	# set -e

[ $# -lt 1 ] && exit 1
[ $# -gt 2 ] && exit 1

BASE_DIR="${0%/*}"

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
	find . -name '*.[ch]' | xargs sed -i 's/ \+$//'
	find . -name '*.[ch]' | xargs sed -i 's/FOREVER$/while (true)/'
	find . -name '*.[ch]' | xargs sed -i -f "$BASE_DIR/merge-upstream.sed"
	find . -name '*.[ch]' | xargs clang-format -i
}

function remove_underscores()
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

function rename_files()
{
	mkdir -p hcache
	[ -f hcache.c         ] && git mv hcache.c         hcache/hcache.c
	[ -f hcache.h         ] && git mv hcache.h         hcache/hcache.h
	[ -f hcache_backend.h ] && git mv hcache_backend.h hcache/backend.h
	[ -f hcache_bdb.c     ] && git mv hcache_bdb.c     hcache/bdb.c
	[ -f hcache_gdbm.c    ] && git mv hcache_gdbm.c    hcache/gdbm.c
	[ -f hcache_kc.c      ] && git mv hcache_kc.c      hcache/kc.c
	[ -f hcache_lmdb.c    ] && git mv hcache_lmdb.c    hcache/lmdb.c
	[ -f hcache_qdbm.c    ] && git mv hcache_qdbm.c    hcache/qdbm.c
	[ -f hcache_tc.c      ] && git mv hcache_tc.c      hcache/tc.c
	[ -f hcachever.sh.in  ] && git mv hcachever.sh.in  hcache/hcachever.sh

	mkdir -p ncrypt
	[ -f crypt.c                   ] && git mv crypt.c                   ncrypt/crypt.c
	[ -f crypt.h                   ] && git mv crypt.h                   ncrypt/crypt.h
	[ -f cryptglue.c               ] && git mv cryptglue.c               ncrypt/cryptglue.c
	[ -f cryptglue.h               ] && git mv cryptglue.h               ncrypt/cryptglue.h
	[ -f crypt_gpgme.c             ] && git mv crypt_gpgme.c             ncrypt/crypt_gpgme.c
	[ -f crypt_gpgme.h             ] && git mv crypt_gpgme.h             ncrypt/crypt_gpgme.h
	[ -f crypt_mod.c               ] && git mv crypt_mod.c               ncrypt/crypt_mod.c
	[ -f crypt_mod.h               ] && git mv crypt_mod.h               ncrypt/crypt_mod.h
	[ -f crypt_mod_pgp_classic.c   ] && git mv crypt_mod_pgp_classic.c   ncrypt/crypt_mod_pgp_classic.c
	[ -f crypt_mod_pgp_gpgme.c     ] && git mv crypt_mod_pgp_gpgme.c     ncrypt/crypt_mod_pgp_gpgme.c
	[ -f crypt_mod_smime_classic.c ] && git mv crypt_mod_smime_classic.c ncrypt/crypt_mod_smime_classic.c
	[ -f crypt_mod_smime_gpgme.c   ] && git mv crypt_mod_smime_gpgme.c   ncrypt/crypt_mod_smime_gpgme.c
	[ -f gnupgparse.c              ] && git mv gnupgparse.c              ncrypt/gnupgparse.c
	[ -f gnupgparse.h              ] && git mv gnupgparse.h              ncrypt/gnupgparse.h
	[ -f ncrypt.h                  ] && git mv ncrypt.h                  ncrypt/ncrypt.h
	[ -f pgp.c                     ] && git mv pgp.c                     ncrypt/pgp.c
	[ -f pgp.h                     ] && git mv pgp.h                     ncrypt/pgp.h
	[ -f pgpinvoke.c               ] && git mv pgpinvoke.c               ncrypt/pgpinvoke.c
	[ -f pgpinvoke.h               ] && git mv pgpinvoke.h               ncrypt/pgpinvoke.h
	[ -f pgpkey.c                  ] && git mv pgpkey.c                  ncrypt/pgpkey.c
	[ -f pgpkey.h                  ] && git mv pgpkey.h                  ncrypt/pgpkey.h
	[ -f pgplib.c                  ] && git mv pgplib.c                  ncrypt/pgplib.c
	[ -f pgplib.h                  ] && git mv pgplib.h                  ncrypt/pgplib.h
	[ -f pgpmicalg.c               ] && git mv pgpmicalg.c               ncrypt/pgpmicalg.c
	[ -f pgpmicalg.h               ] && git mv pgpmicalg.h               ncrypt/pgpmicalg.h
	[ -f pgppacket.c               ] && git mv pgppacket.c               ncrypt/pgppacket.c
	[ -f pgppacket.h               ] && git mv pgppacket.h               ncrypt/pgppacket.h
	[ -f smime.c                   ] && git mv smime.c                   ncrypt/smime.c
	[ -f smime.h                   ] && git mv smime.h                   ncrypt/smime.h
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
	remove_underscores
	rename_files
	indent_manual
	git add .
	git commit -m "sync source"
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

