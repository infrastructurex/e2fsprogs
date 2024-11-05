#!/usr/bin/env sh

VERSION=1.47.1
SOURCE=https://github.com/tytso/e2fsprogs/archive/refs/tags/v$VERSION.tar.gz

echo Downloading e2fsprogs "$VERSION" ...
cd /build || exit
wget "$SOURCE"

echo Extracting e2fsprogs "$VERSION" ...
tar -xf v$VERSION.tar.gz
mv e2fsprogs-$VERSION e2fsprogs

echo Building e2fsprogs ...
cd /build/e2fsprogs || exit

mkdir build
cd build || exit
../configure
make "-j$(nproc)" || exit
strip misc/mke2fs

echo Packaging e2fsprogs ...
mkdir -p /export/sbin
cd /export || exit

cp /build/e2fsprogs/build/misc/mke2fs sbin

mkdir legal
cat > legal/e2fsprogs<< EOF
Source  : $SOURCE
Version : $VERSION
Package : https://github.com/infrastructurex/e2fsprogs/e2fsprogs/download/$TAG/e2fsprogs-$ARCH-$TAG.tar.gz
License :

EOF
cat /build/e2fsprogs/NOTICE >> legal/e2fsprogs
gzip legal/e2fsprogs

tar -czvf /e2fsprogs.tar.gz *
