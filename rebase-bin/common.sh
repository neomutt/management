# Shared functions

function remove_files()
{
	rm -fr intl
	rm -f .hgignore
	rm -f .hgsigs
	rm -f .hgtags
	rm -f ABOUT-NLS
	rm -f BEWARE
	rm -f build-release
	rm -f check_sec.sh
	rm -f contrib/mutt_xtitle
	rm -f contrib/sample.muttrc-compress
	rm -f contrib/sample.muttrc-sidebar
	rm -f contrib/sample.vimrc-sidebar
	rm -f crypthash.h
	rm -f doc/applying-patches.txt
	rm -f doc/devel-notes.txt
	rm -f doc/dotlock.man
	rm -f doc/makedoc-defs.h
	rm -f doc/muttbug.man
	rm -f doc/patch-notes.txt
	rm -f doc/TODO
	rm -f dotlock.c
	rm -f dotlock.h
	rm -f GPL
	rm -f hg-changelog-map
	rm -f hg-commit
	rm -f imap/TODO
	rm -f m4/codeset.m4
	rm -f m4/curslib.m4
	rm -f m4/funcs.m4
	rm -f m4/gettext.m4
	rm -f m4/glibc21.m4
	rm -f m4/gpgme.m4
	rm -f m4/iconv.m4
	rm -f m4/lcmessage.m4
	rm -f m4/progtest.m4
	rm -f m4/types.m4
	rm -f mkchangelog.sh
	rm -f mkdtemp.c
	rm -f muttbug
	rm -f muttbug.sh.in
	rm -f NEWS
	rm -f PATCHES
	rm -f patchlist.sh
	rm -f po/Makefile.in.in
	rm -f README
	rm -f README.SECURITY
	rm -f regex.c
	rm -f snprintf.c
	rm -f strcasecmp.c
	rm -f strdup.c
	rm -f strsep.c
	rm -f strtok_r.c
	rm -f TODO
	rm -f VERSION
	rm -f version.sh
	rm -f _regex.h
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
	[ -f mutt_crypt.h              ] && git mv mutt_crypt.h              ncrypt/ncrypt.h
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

function tidy_source()
{
	local i

	# Fix broken macros: mutt_message _("hello");
	find . -name '*.c'    | xargs perl -0777 -i.orig -pe 's/([a-z_]+) +(_\(.*?\));/\1(\2);/igs'
	# Unused code "#if 0"
	find . -name '*.[ch]' | xargs unifdef -km
	# Fix whitespace
	for i in $(find . -name '*.[ch]'); do
		expand -t 8 $i | sponge $i
	done
	find . -name '*.[ch]' | xargs sed -i 's/ \+$//'
	# Mutt-isms
	find . -name '*.[ch]' | xargs sed -i 's/FOREVER$/while (true)/'
	find . -name '*.[ch]' | xargs sed -i -f "$BASE_DIR/remove-checked-comments.sed"
	# Drop typedef'd structs, rename functions
	find . -name '*.[ch]' | xargs sed -i -f "$BASE_DIR/rename-structs.sed"
	find . -name '*.[ch]' | xargs sed -i -f "$BASE_DIR/rename-functions.sed"
	# Fix exceptions
	sed -i 's/struct Message/MESSAGE/g' ncrypt/crypt_gpgme.c
	# Fix struct definitions
	find . -name '*.[ch]' | xargs sed -i 's/^} struct [A-Za-z0-9_]\+;/};/'
	# Tidy the result
	find . -name '*.c'    | xargs clang-format -i
	# Replace Mutt's dprint() with NeoMutt's mutt_debug()
	find . -name '*.[ch]' | xargs spatch --no-show-diff --in-place --sp-file "$BASE_DIR/dprint.cocci"
	# Initialise pointers to NULL
	find . -name '*.[ch]' | xargs spatch --no-show-diff --in-place --sp-file "$BASE_DIR/set-pointer-null.cocci"
	# Check strcmp-like functions against zero
	find . -name '*.[ch]' | xargs spatch --no-show-diff --in-place --sp-file "$BASE_DIR/strcmp.cocci"
	# Simplify return statements
	find . -name '*.[ch]' | xargs spatch --no-show-diff --in-place --sp-file "$BASE_DIR/tidy-return.cocci"
	# Tidy the result
	find . -name '*.c'    | xargs clang-format -i
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

