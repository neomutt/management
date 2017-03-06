#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

SRC_DIR="$1"
GH_URL="https://github.com/neomutt/neomutt/archive"
AUR_DIR="distro-aur"

pushd "$SRC_DIR"

TAG="$(git tag -l --sort='-authordate' 'neomutt-*' | head -1)"
VERSION="${TAG#neomutt-}"

popd

FILE="$TAG.tar.gz"
if [ ! -f "$FILE" ]; then
	wget "$GH_URL/$FILE"
fi

MD5SUM=$(md5sum "$FILE" | sed 's/ .*//')

echo "AUR"
echo
echo "Version: $VERSION"
echo "Md5sum:  $MD5SUM"
echo "Archive: $GH_URL/$FILE"

echo
echo "Edit:"
echo "    PKGBUILD"
sed -i \
	-e "s/^\(pkgver\)=.*/\1=$VERSION/" \
	-e "s/^\(md5sums\)=('.*/\1=('$MD5SUM')/" \
	"$AUR_DIR/PKGBUILD"

echo "    .SRCINFO"
sed -i \
	-e "s/^\(\tpkgver\) =.*/\1 = $VERSION/" \
	-e "s/^\(\tmd5sums\) =.*/\1 = $MD5SUM/" \
	-e "s!^\(\tsource\) =.*!\1 = $GH_URL/$FILE!" \
	"$AUR_DIR/.SRCINFO"
echo
