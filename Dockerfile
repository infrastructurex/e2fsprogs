FROM alpine:3.21.2 AS build

ARG ARCH
ENV ARCH=$ARCH
ARG TAG
ENV TAG=$TAG

RUN apk add wget bash gcc musl-dev linux-headers make upx
ADD build.sh /build/build.sh
RUN /build/build.sh


FROM scratch AS export
COPY --from=build /e2fsprogs.tar.gz .
