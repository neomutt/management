#!/bin/bash

set -o nounset	# set -u

if [ ! -f config.h ]; then
	echo "config.h is missing"
	exit 1
fi

if [ ! -f hcache/hcversion.h ]; then
	echo "hcache/hcversion.h is missing"
	exit 1
fi

function ifdef()
{
	local VAR="$1"
	local COMMAND="$2"
	shift 2

	grep -q "$VAR 1" config.h || return

	$COMMAND "$@"
}

function ifndef()
{
	local VAR="$1"
	local COMMAND="$2"
	shift 2

	grep -q "$VAR 1" config.h && return

	$COMMAND "$@"
}

function autocrypt()
{
	for i in autocrypt/*.[ch]; do
		ifdef USE_AUTOCRYPT i-main.sh "$i"
	done
}

function notmuch()
{
	for i in notmuch/*.[ch]; do
		ifdef USE_NOTMUCH i-main.sh "$i"
	done
}

function hcache()
{
	for i in hcache/*.[ch]; do
		case "$i" in
			hcache/bdb.c)       ifdef HAVE_BDB   i-main.sh "$i" ;;
			hcache/gdbm.c)      ifdef HAVE_GDBM  i-main.sh "$i" ;;
			hcache/kc.c)        ifdef HAVE_KC    i-main.sh "$i" ;;
			hcache/lmdb.c)      ifdef HAVE_LMDB  i-main.sh "$i" ;;
			hcache/qdbm.c)      ifdef HAVE_QDBM  i-main.sh "$i" ;;
			hcache/tc.c)        ifdef HAVE_TC    i-main.sh "$i" ;;
			hcache/hcache.c)    ifdef USE_HCACHE i-main.sh "$i" ;;
			hcache/serialize.c) ifdef USE_HCACHE i-main.sh "$i" ;;
			*)                                   i-main.sh "$i" ;;
		esac
	done
}

function imap()
{
	for i in imap/*.[ch]; do
		case "$i" in
			imap/auth_anon.c) ifndef HAVE_SASL i-main.sh "$i" ;;
			imap/auth_cram.c) ifndef HAVE_SASL i-main.sh "$i" ;;
			imap/auth_sasl.c) ifdef  HAVE_SASL i-main.sh "$i" ;;
			imap/auth_gss.c)  ifdef  USE_GSS   i-main.sh "$i" ;;
			*)                                 i-main.sh "$i" ;;
		esac
	done
}

function ncrypt()
{
	for i in ncrypt/*.[ch]; do
		case "$i" in
			ncrypt/crypt_gpgme.c)             ifdef HAVE_GPGME i-main.sh "$i" ;;
			ncrypt/crypt_mod_pgp_gpgme.c)     ifdef HAVE_GPGME i-main.sh "$i" ;;
			ncrypt/crypt_mod_smime_gpgme.c)   ifdef HAVE_GPGME i-main.sh "$i" ;;
			ncrypt/crypt_mod_pgp_classic.c)   ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/gnupgparse.c)              ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/pgp.c)                     ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/pgpinvoke.c)               ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/pgpkey.c)                  ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/pgplib.c)                  ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/pgpmicalg.c)               ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/pgppacket.c)               ifdef HAVE_PGP   i-main.sh "$i" ;;
			ncrypt/crypt_mod_smime_classic.c) ifdef HAVE_SMIME i-main.sh "$i" ;;
			ncrypt/smime.c)                   ifdef HAVE_SMIME i-main.sh "$i" ;;
			*)                                                 i-main.sh "$i" ;;
		esac
	done
}

function conn()
{
	for i in conn/*.[ch]; do
		case "$i" in
			conn/sasl.c)       ifdef  HAVE_SASL       i-conn.sh "$i" ;;
			conn/ssl_gnutls.c) ifdef  USE_SSL_GNUTLS  i-conn.sh "$i" ;;
			conn/ssl.c)        ifdef  USE_SSL_OPENSSL i-conn.sh "$i" ;;
			*)                                        i-conn.sh "$i" ;;
		esac
	done
}

function root()
{
	for i in *.[ch]; do
		case "$i" in
			wcscasecmp.c)      ifndef HAVE_WCSCASECMP i-main.sh "$i" ;;
			backtrace.c)       ifdef  HAVE_LIBUNWIND  i-main.sh "$i" ;;
			remailer.c)        ifdef  MIXMASTER       i-main.sh "$i" ;;
			monitor.c)         ifdef  USE_INOTIFY     i-main.sh "$i" ;;
			mutt_lua.c)        ifdef  USE_LUA         i-main.sh "$i" ;;
			*)                                        i-main.sh "$i" ;;
		esac
	done
}

i-address.sh address/*.[ch]
i-config.sh  config/*.[ch]
i-core.sh    core/*.[ch]
i-email.sh   email/*.[ch]
i-mutt.sh    mutt/*.[ch]

i-main.sh \
	maildir/*.[ch] \
	mbox/*.[ch] \
	nntp/*.[ch] \
	pop/*.[ch] \

autocrypt
conn
hcache
imap
ncrypt
notmuch
root

