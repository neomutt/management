#!/bin/bash

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

function log_error()
{
	echo -e "\\e[1;31m$*\\e[m"
}

function log_success()
{
	echo -e "\\e[1;32m$*\\e[m"
}

function die()
{
	if [ $? = 1 ]; then
		log_error "Build failed"
	fi
}


trap die EXIT

COMPILERS=(
	gcc
	# clang
)

OPTIONS=(
	# Default config
	""
	# Disable components that default to 'on'
	"--disable-nls"
	"--disable-idn"
	"--disable-pgp"
	"--disable-smime"
	# Disable ALL optional components
	"--disable-nls --disable-idn --disable-pgp --disable-smime"
	# Enable components that default to 'off'
	"--lua"
	"--with-lock=flock"
	# "--enable-nfs-fix"
	"--locales-fix"
	# "--enable-exact-address"
	"--homespool"
	"--with-domain=example.com"
	"--notmuch"
	"--gpgme"
	# Enable ALL optional components
	"--with-lock=flock --lua --locales-fix --homespool --with-domain=example.com --notmuch --gpgme"
	# Test all the backend caching options
	# "--tokyocabinet"
	# "--qdbm"
	# "--gdbm"
	# "--bdb"
	# "--lmdb"
	# "--kyotocabinet"
	"--tokyocabinet --qdbm --gdbm --bdb --lmdb --kyotocabinet"
	# Test the components that have dependencies on others
	"--gss"
	"--ssl"
	"--gnutls"
	"--sasl"
	# Miscellaneous options
	# "--with-mailpath=/home/mutt/mail"
)

FAILURES=()

TOTAL=$((${#COMPILERS[@]} * ${#OPTIONS[@]})) 
echo "Testing $TOTAL configurations"

if [ -f configure ]; then
	CONFIGURE="./configure"
elif [ -f ../configure ]; then
	CONFIGURE="../configure"
else
	echo "Can't find configure.  Aborting."
	exit 1
fi

COUNT=0
SUCCESS=0
for c in "${COMPILERS[@]}"; do
	echo "------------------------------------------------------------------------------"
	echo -e "\\e[1;35mCOMPILER: $c\\e[m"
	for o in "${OPTIONS[@]}"; do
		: $((COUNT++))
		echo "------------------------------------------------------------------------------"
		echo -e "\\e[1;36mBuild $COUNT of $TOTAL\\e[m -- $(date '+%F %R:%S')"
		echo -e "\\e[1m$CONFIGURE $o\\e[m"
		echo
		git clean -xdfq
		chronic $CONFIGURE --disable-doc $o CC="$c"
		if make -s CC="$c" EXTRA_CFLAGS="${EXTRA_CFLAGS[*]}" EXTRA_LDFLAGS="${EXTRA_LDFLAGS[*]}"; then
			log_success "Build succeeded"
			: $((SUCCESS++))
		else
			FAILURES+=("$o")
			log_error "Build failed"
		fi
	done
done

git clean -xdfq

if [ $SUCCESS = $COUNT ]; then
	log_success "Success: $SUCCESS/$COUNT builds succeeded"
else
	log_error "Only: $SUCCESS/$COUNT builds succeeded"
	echo "Failed configurations:"
	for i in "${FAILURES[@]}"; do
		echo "    $CONFIGURE $i"
	done
fi
date '+%F %R:%S'

