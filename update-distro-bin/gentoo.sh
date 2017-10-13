#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

eval SRC_DIR="${1:-~/work/neo}"
GENTOO_DIR="gentoo/mail-client/neomutt"
GH_URL="https://github.com/neomutt/neomutt/archive"

pushd "$SRC_DIR"

TAG="$(cd "$SRC_DIR"; git tag -l --sort='-authordate' 'neomutt-*' | head -1)"
VERSION="${TAG#neomutt-}"

popd

FILE="$TAG.tar.gz"
if [ ! -f "$FILE" ]; then
	wget "$GH_URL/$FILE"
fi

SIZE=$(stat -c %s "$FILE")
SHA256=$(sha256sum "$FILE" | sed 's/ .*//')
SHA512=$(sha512sum "$FILE" | sed 's/ .*//')
WHIRLPOOL=$(whirlpoolsum "$FILE" | sed 's/ .*//')

echo "Gentoo"
echo
echo "Version:   $VERSION"
echo "Size:      $SIZE"
echo "SHA256:    $SHA256"
echo "SHA512:    $SHA512"
echo "Whirlpool: $WHIRLPOOL"
echo "Archive:   $GH_URL/$FILE"

echo DIST $FILE $SIZE SHA256 $SHA256 SHA512 $SHA512 WHIRLPOOL $WHIRLPOOL > "$GENTOO_DIR/Manifest"

LIVE_EBUILD="$GENTOO_DIR/neomutt-99999999.ebuild"
OLD_EBUILD="$(find "$GENTOO_DIR" -name 'neomutt-2*.ebuild')"
NEW_EBUILD="$GENTOO_DIR/neomutt-$VERSION.ebuild"

echo
echo "Rename:"
echo "    $OLD_EBUILD"
echo "    $NEW_EBUILD"
echo

[ "$OLD_EBUILD" != "$NEW_EBUILD" ] && { cp "$LIVE_EBUILD" "$NEW_EBUILD" && rm "$OLD_EBUILD"; }
