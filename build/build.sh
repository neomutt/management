#!/bin/bash

if [ -f configure ] && [ -f auto.def ]; then
	REL="."
elif [ -f ../configure ] && [ -f ../auto.def ]; then
	REL=".."
else
	echo "Can't find build files"
	exit 1
fi

# CC="g++"
CC="gcc"
# CC="clang"
# LD="lld"

# BUILD_DIR="${1:-.build}"
# [ -n "$1" ] && shift

CONFIGURE=()

function ifdef()
{
	[ -n "$1" ] || return
	grep -q -- "$1" "$REL/auto.def" && CONFIGURE+=("--$1")
}

function die()
{
	if [ $? = 0 ]; then
		echo -e "\\e[1;32mSuccess\\e[m\\n"
	else
		echo -e "\\e[1;31mFAILURE\\e[m\\n"
	fi
}

trap die EXIT

# CONFIGURE+=("--testing")          # Enable Unit Testing
# CONFIGURE+=("--coverage")         # Enable Coverage Testing
# CONFIGURE+=("--fuzzing")          # Enable Fuzz Testing

CONFIGURE+=("--quiet")             # Configure quietly

ifdef "autocrypt"       # Enable AutoCrypt support (requires gpgme and sqlite)
ifdef "pkgconf"         # Use pkg-config during configure

# Debug
# ifdef "debug-account"    # Enable account dump
# ifdef "debug-backtrace"  # Enable backtrace support with libunwind
# ifdef "debug-graphviz"   # Enable Graphviz dump
# ifdef "debug-email"      # Enable Email dump
# ifdef "debug-notify"     # Enable Notifications dump
# ifdef "debug-parse-test" # Enable 'neomutt -T' for config testing
# ifdef "debug-window"     # Enable Windows dump
# ifdef "asan"             # Enable the Address Sanitizer

# Devel
# ifdef "devel-help"       # Enable Help Backend

# Compression
ifdef "lz4"             # Enable LZ4 header cache compression support
ifdef "zlib"            # Enable zlib header cache compression support
ifdef "zstd"            # Enable Zstandard header cache compression

CONFIGURE+=("--prefix=/usr")     # Target directory for the build
# CONFIGURE+=("--with-tmpdir=/tmp") # Location of the tmp directory

CONFIGURE+=("--with-ui=ncurses") # Select ncurses for the UI
# CONFIGURE+=("--with-ui=slang")   # Select slang for the UI

CONFIGURE+=("--with-lock=fcntl") # Use fcntl to lock files (default)
# CONFIGURE+=("--with-lock=flock") # Use flock to lock files
# CONFIGURE+=("--disable-inotify") # Disable file monitoring support (Linux only)

CONFIGURE+=("--with-domain=flatcap.org")   # Specify your DNS domain name
CONFIGURE+=("--fmemopen")        # Use fmemopen() for temporary in-memory files
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
# CONFIGURE+=("--full-doc")        # Build ALL the docs
CONFIGURE+=("--disable-doc")     # Disable building the documentation
CONFIGURE+=("--disable-idn")     # Disable GNU libidn for internationalized domain names
CONFIGURE+=("--idn2")            # Enable GNU libidn2 for internationalized domain names
# CONFIGURE+=("--disable-nls")     # Disable Native Language Support
# CONFIGURE+=("--disable-pgp")     # Disable PGP support
# CONFIGURE+=("--disable-smime")   # Disable SMIME support

# Stores
ifdef "bdb"            # Use BerkeleyDB for the header cache
ifdef "gdbm"           # Use GNU dbm for the header cache
ifdef "kyotocabinet"   # Use KyotoCabinet for the header cache
ifdef "lmdb"           # Use LMDB for the header cache
ifdef "qdbm"           # Use QDBM for the header cache
ifdef "rocksdb"        # Use RocksDB for the header cache
ifdef "tdb"            # Use TDB for the header cache
ifdef "tokyocabinet"   # Use TokyoCabinet for the header cache

ifdef "pcre2"                    # Enable PCRE2 regular expressions

# CONFIGURE+=("--libexecdir=/usr/wibble")

# ------------------------------------------------------------------------------

EXTRA_CFLAGS=()

# EXTRA_CFLAGS+=("-g")
EXTRA_CFLAGS+=("-ggdb3")
# EXTRA_CFLAGS+=("-rdynamic")
EXTRA_CFLAGS+=("-O0")
# EXTRA_CFLAGS+=("-O2")
# EXTRA_CFLAGS+=("-D_FORTIFY_SOURCE=2")
EXTRA_CFLAGS+=("-DDEBUG")
# EXTRA_CFLAGS+=("-DRECORD_FOLDER_HOOK")
EXTRA_CFLAGS+=("-std=c99")

EXTRA_CFLAGS+=("-Werror")
EXTRA_CFLAGS+=("-Wall")
EXTRA_CFLAGS+=("-Wfloat-equal")
EXTRA_CFLAGS+=("-Winit-self")
EXTRA_CFLAGS+=("-Wpointer-arith")
EXTRA_CFLAGS+=("-Wshadow")
EXTRA_CFLAGS+=("-Wstrict-aliasing=1")
EXTRA_CFLAGS+=("-Wtautological-compare")
EXTRA_CFLAGS+=("-Wundef")

[ "$CC" = "gcc" ] && EXTRA_CFLAGS+=("-Wcast-align")

# EXTRA_CFLAGS+=("-Wredundant-decls")
# EXTRA_CFLAGS+=("-Wstrict-prototypes")
# EXTRA_CFLAGS+=("-Wmissing-prototypes")

# EXTRA_CFLAGS+=("-Wc++-compat")
# EXTRA_CFLAGS+=("-Wcast-qual")
# EXTRA_CFLAGS+=("-Wconversion")
# EXTRA_CFLAGS+=("-Wextra")
# EXTRA_CFLAGS+=("-Wformat=2")
# EXTRA_CFLAGS+=("-Wswitch-enum")
# EXTRA_CFLAGS+=("-Wvla")

EXTRA_CFLAGS+=("-Wformat-security")
EXTRA_CFLAGS+=("-Wpedantic")
EXTRA_CFLAGS+=("-Wunused-result")
# EXTRA_CFLAGS+=("-Wdiscarded-array-qualifiers")
# EXTRA_CFLAGS+=("-Wdiscarded-qualifiers")
# EXTRA_CFLAGS+=("-Wif-not-aligned")
# EXTRA_CFLAGS+=("-Wjump-misses-init")
# EXTRA_CFLAGS+=("-Wmacro-redefined")
# EXTRA_CFLAGS+=("-Wmissing-field-initializers")
# EXTRA_CFLAGS+=("-Wsuggest-attribute=format")
# EXTRA_CFLAGS+=("-Wunused-parameter")

[ "$CC" = "gcc" ] && EXTRA_CFLAGS+=("-Wformat-truncation=0") # 2 to be thorough
[ "$CC" = "gcc" ] && EXTRA_CFLAGS+=("-Wimplicit-fallthrough=2")

# EXTRA_CFLAGS+=("-fprofile-arcs -ftest-coverage")
EXTRA_CFLAGS+=("-fdiagnostics-color=auto") # auto,never,always
EXTRA_CFLAGS+=("-fno-diagnostics-show-option")
# [ "$CC" = "gcc" ] && EXTRA_CFLAGS+=("-fno-diagnostics-show-caret")
# [ "$CC" = "gcc" ] && EXTRA_CFLAGS+=("-fno-diagnostics-show-labels")
# [ "$CC" = "gcc" ] && EXTRA_CFLAGS+=("-fno-diagnostics-show-line-numbers")
# EXTRA_CFLAGS+=("-fdump-rtl-expand")
# EXTRA_CFLAGS+=("-fanalyzer")

# ------------------------------------------------------------------------------

# EXTRA_CFLAGS+=("-fsanitize=-fsanitize=fuzzer")
# EXTRA_CFLAGS+=("-fsanitize=address")
# EXTRA_CFLAGS+=("-fsanitize-recover=address")
# EXTRA_CFLAGS+=("-fsanitize-address-use-after-scope")
# EXTRA_CFLAGS+=("-fsanitize=leak")
# EXTRA_CFLAGS+=("-fsanitize=undefined -fno-sanitize-recover=undefined")
# EXTRA_CFLAGS+=("-fsanitize=undefined")
# EXTRA_CFLAGS+=("-fsanitize=address -fno-sanitize-recover=address")

# ------------------------------------------------------------------------------

EXTRA_LDFLAGS=()
# EXTRA_LDFLAGS+=("-rdynamic")
# EXTRA_LDFLAGS+=("-fsanitize=-fsanitize=fuzzer")
# EXTRA_LDFLAGS+=("-fprofile-arcs -ftest-coverage")
# EXTRA_LDFLAGS+=("-fsanitize=address")
# EXTRA_LDFLAGS+=("-fsanitize-recover=address")
# EXTRA_LDFLAGS+=("-fsanitize-address-use-after-scope")
# EXTRA_LDFLAGS+=("-fsanitize=leak -llsan")
# EXTRA_LDFLAGS+=("-fsanitize=undefined -fno-sanitize-recover=undefined")
# EXTRA_LDFLAGS+=("-fsanitize=undefined")
# EXTRA_LDFLAGS+=("--as-needed")
# EXTRA_LDFLAGS+=("-fsanitize=address -fno-sanitize-recover=address")
# EXTRA_LDFLAGS+=("-lunwind -lunwind-generic")

# ------------------------------------------------------------------------------

find . -name '*.[ch]' ! -path './autosetup/*' ! -path './test/*' ! -path './docs/*' ! -path './pgpewrap.c' | cut -b3- | xargs --no-run-if-empty ctags

if [ -n "$BUILD_DIR" ]; then
	rm -f neomutt *.a config.h
	rm -fr "$BUILD_DIR"
	mkdir "$BUILD_DIR"
	pushd "$BUILD_DIR" >& /dev/null
fi

# echo "$CONFIGURE_SH ${CONFIGURE[@]} CC=\"$CC\" EXTRA_CFLAGS=\"${EXTRA_CFLAGS[*]}\" LD=\"$LD\" EXTRA_LDFLAGS=\"${EXTRA_LDFLAGS[*]}\""
echo -n configure...
chronic "$REL/configure" \
	"${CONFIGURE[@]}" \
	CC="$CC" EXTRA_CFLAGS="${EXTRA_CFLAGS[*]}" \
	LD="$LD" EXTRA_LDFLAGS="${EXTRA_LDFLAGS[*]}" \

echo

make -s hcache/hcversion.h

if [ -n "$BUILD_DIR" ]; then
	popd >& /dev/null
	cp -sf "$BUILD_DIR"/config.h .
	pushd "$BUILD_DIR" >& /dev/null
fi

[ "$1" = "-n" ] && exit 0

echo build...
# echo "make -sk CC=\"$CC\" LD=\"$LD\" EXTRA_CFLAGS=\"${EXTRA_CFLAGS[*]}\" EXTRA_LDFLAGS=\"${EXTRA_LDFLAGS[*]}\""
make -sk CC="$CC" LD="$LD" EXTRA_CFLAGS="${EXTRA_CFLAGS[*]}" EXTRA_LDFLAGS="${EXTRA_LDFLAGS[*]}"
RETVAL=$?

[ $RETVAL = 0 ] || exit $RETVAL
if [[ "${CONFIGURE[*]}" =~ --testing ]]; then
	echo test...
	chronic make test
	RETVAL=$?
fi

[ $RETVAL = 0 ] || exit $RETVAL
if [[ "${CONFIGURE[*]}" =~ --coverage ]]; then
	echo coverage...
	chronic make coverage
	RETVAL=$?
fi

# [ $RETVAL = 0 ] || exit $RETVAL
# echo doxygen...
# chronic doxygen doxygen/doxygen.conf
# RETVAL=$?

[ $RETVAL = 0 ] || exit $RETVAL
if [ -n "$BUILD_DIR" ]; then
	popd >& /dev/null
	cp -sf "$BUILD_DIR"/neomutt .
	# cp -sf "$BUILD_DIR"/*.a .
fi

# ./neomutt -v > neomutt.txt
exit $RETVAL

