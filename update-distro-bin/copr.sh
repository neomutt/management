#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

eval SRC_DIR="${1:-~/work/neo}"
GH_URL="https://github.com/neomutt/neomutt/archive"

pushd "$SRC_DIR"

TAG="$(git tag -l --sort='authordate' '202*' | tail -1)"
VERSION="${TAG//-}"

popd

FILE="$TAG.tar.gz"
if [ ! -f "$FILE" ]; then
	wget "$GH_URL/$FILE"
fi

echo "Tag:     $TAG"
echo "Version: $VERSION"
echo

pushd copr

SPEC="neomutt.spec"
OS="fc39"
HERE=$(pwd)

echo "Edit: $SPEC"
sed -i \
	-e "s/^\(Version:\) .*/\1 $VERSION/" \
	"$SPEC"
echo

rm -fr rpmbuild
rm -fr *.rpm
rpmdev-setuptree

cp ../${VERSION}.tar.gz rpmbuild/SOURCES/neomutt-${VERSION}.tar.gz
cp *.patch              rpmbuild/SOURCES
cp fedora-colors.rc     rpmbuild/SOURCES

rpmbuild -bs --target=noarch --define=_topdir\ $HERE/rpmbuild "$SPEC"

cp rpmbuild/SRPMS/neomutt-${VERSION}-1.${OS}.src.rpm .

rm -fr rpmbuild
# exit 0
rpmdev-setuptree

rpmbuild --rebuild --define=_topdir\ $HERE/rpmbuild neomutt-${VERSION}-1.${OS}.src.rpm

cp rpmbuild/RPMS/*/*.rpm .

rm -fr rpmbuild
popd

