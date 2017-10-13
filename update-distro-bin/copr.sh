#!/bin/bash

set -o errexit	# set -e
set -o nounset	# set -u

rpmbuild_tree()
{
	mkdir -p rpmbuild/BUILD
	mkdir -p rpmbuild/BUILDROOT
	mkdir -p rpmbuild/RPMS/athlon
	mkdir -p rpmbuild/RPMS/i386
	mkdir -p rpmbuild/RPMS/i586
	mkdir -p rpmbuild/RPMS/i686
	mkdir -p rpmbuild/RPMS/noarch
	mkdir -p rpmbuild/RPMS/x86_64
	mkdir -p rpmbuild/SOURCES
	mkdir -p rpmbuild/SPECS
	mkdir -p rpmbuild/SRPMS
}


eval SRC_DIR="${1:-~/work/neo}"
GH_URL="https://github.com/neomutt/neomutt/archive"

pushd "$SRC_DIR"

TAG="$(git tag -l --sort='-authordate' 'neomutt-*' | head -1)"
VERSION="${TAG#neomutt-}"

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
OS="fc26"
HERE=$(pwd)

echo "Edit: $SPEC"
sed -i \
	-e "s/^\(Version:\) .*/\1 $VERSION/" \
	"$SPEC"
echo

rm -fr rpmbuild
rpmbuild_tree

cp ../neomutt-${VERSION}.tar.gz rpmbuild/SOURCES
cp *.patch                      rpmbuild/SOURCES
cp mutt_ldap_query              rpmbuild/SOURCES

rpmbuild -bs --target=noarch --define=_topdir\ $HERE/rpmbuild "$SPEC"

cp rpmbuild/SRPMS/neomutt-${VERSION}-1.${OS}.src.rpm .

rm -fr rpmbuild
rpmbuild_tree

rpmbuild --rebuild --define=_topdir\ $HERE/rpmbuild neomutt-${VERSION}-1.${OS}.src.rpm

cp rpmbuild/RPMS/x86_64/* .

rm -fr rpmbuild
popd

