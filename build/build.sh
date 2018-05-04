#!/bin/bash

CONFIGURE=()

CONFIGURE+=("--quiet")           # Configure quietly

CONFIGURE+=("--prefix=/usr")     # Target directory for the build

CONFIGURE+=("--with-ui=ncurses") # Select ncurses for the UI
# CONFIGURE+=("--with-ui=slang")   # Select slang for the UI

CONFIGURE+=("--with-lock=fcntl") # Use fcntl to lock files (default)
# CONFIGURE+=("--with-lock=flock") # Use flock to lock files

# CONFIGURE+=("--with-domain=flatcap.org")   # Specify your DNS domain name
# CONFIGURE+=("--fmemopen")        # Use fmemopen() for temporary in-memory files
# CONFIGURE+=("--locales-fix")     # Enable locales fix

# Encryption
# CONFIGURE+=("--ssl")             # Enable TLS support using OpenSSL
CONFIGURE+=("--gnutls")          # Enable TLS support using GnuTLS

# Security
CONFIGURE+=("--gpgme")           # Enable GPGME support
CONFIGURE+=("--gss")             # Use GSSAPI authentication for IMAP
CONFIGURE+=("--sasl")            # Use the SASL network security library

# Features
CONFIGURE+=("--lua")             # Enable Lua scripting support
CONFIGURE+=("--notmuch")         # Enable Notmuch support
CONFIGURE+=("--mixmaster")       # Enable Mixmaster support

# Most people want these enabled
CONFIGURE+=("--disable-doc")     # Disable building the documentation
# CONFIGURE+=("--disable-idn")     # Disable GNU libidn for internationalized domain names
# CONFIGURE+=("--disable-nls")     # Disable Native Language Support
# CONFIGURE+=("--disable-pgp")     # Disable PGP support
# CONFIGURE+=("--disable-smime")   # Disable SMIME support

# Header cache backends
CONFIGURE+=("--bdb")             # Use BerkeleyDB for the header cache
CONFIGURE+=("--gdbm")            # Use GNU dbm for the header cache
CONFIGURE+=("--kyotocabinet")    # Use KyotoCabinet for the header cache
CONFIGURE+=("--lmdb")            # Use LMDB for the header cache
CONFIGURE+=("--qdbm")            # Use QDBM for the header cache
CONFIGURE+=("--tokyocabinet")    # Use TokyoCabinet for the header cache

# ------------------------------------------------------------------------------

EXTRA_CFLAGS=()

EXTRA_CFLAGS+=("-ggdb3")
EXTRA_CFLAGS+=("-O0")
EXTRA_CFLAGS+=("-DDEBUG")
EXTRA_CFLAGS+=("-std=c99")
# EXTRA_CFLAGS+=("-Wextra")
# EXTRA_CFLAGS+=("-Wunused-parameter")
EXTRA_CFLAGS+=("-Wpedantic")
EXTRA_CFLAGS+=("-Wformat-security")
# EXTRA_CFLAGS+=("-Wmacro-redefined")
EXTRA_CFLAGS+=("-Wshadow")
EXTRA_CFLAGS+=("-Wstrict-prototypes")
# EXTRA_CFLAGS+=("-Wsuggest-attribute=format")
EXTRA_CFLAGS+=("-Wundef")
EXTRA_CFLAGS+=("-Wunused-result")
EXTRA_CFLAGS+=("-Wimplicit-fallthrough")
EXTRA_CFLAGS+=("-Wformat-truncation=0");
EXTRA_CFLAGS+=("-Werror")

# EXTRA_CFLAGS+=("-fsanitize=address -fsanitize-recover=address")
# EXTRA_CFLAGS+=("-fsanitize=undefined -fno-sanitize-recover=undefined")
# EXTRA_CFLAGS+=("-fsanitize=undefined")
# EXTRA_CFLAGS+=("-fsanitize=address -fsanitize=bool -fsanitize=enum")

# ------------------------------------------------------------------------------

EXTRA_LDFLAGS=()
# EXTRA_LDFLAGS+=("-fprofile-arcs -ftest-coverage")
# EXTRA_LDFLAGS+=("-fsanitize=address -fsanitize-recover=address")
# EXTRA_LDFLAGS+=("-fsanitize=undefined")

# ------------------------------------------------------------------------------

CC="gcc"
# CC="clang"
# LD="lld"

echo -n configure...
chronic ./configure \
	"${CONFIGURE[@]}" \
	CC="$CC" EXTRA_CFLAGS="${EXTRA_CFLAGS[*]}" \
	LD="$LD" EXTRA_LDFLAGS="${EXTRA_LDFLAGS[*]}" \

echo

echo build...
make -sk CC="$CC" LD="$LD" EXTRA_CFLAGS="${EXTRA_CFLAGS[*]}" EXTRA_LDFLAGS="${EXTRA_LDFLAGS[*]}"
RETVAL=$?

[ $RETVAL = 0 ] && echo -e "\\n\\e[1;32mSuccess\\e[m\\n" || echo -e "\\n\\e[1;31mFAILURE\\e[m\\n"

find . -name '*.[ch]' ! -path './autosetup/*' ! -path './test/*' ! -path './doc/*' ! -path './pgp*.c' | cut -b3- | xargs --no-run-if-empty ctags

exit $RETVAL

