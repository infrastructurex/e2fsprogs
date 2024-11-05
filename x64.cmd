docker buildx build --platform=linux/amd64 --progress=plain --output type=local,dest=build/x64 .
docker run --rm --privileged -v x:\workspaces\e2fsprogs\build\x64\e2fsprogs.tar.gz:/e2fsprogs.tar.gz alpine sh -c "tar xzf /e2fsprogs.tar.gz && /sbin/mkfs.ext4"
