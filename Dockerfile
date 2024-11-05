FROM alpine:3.20.3 AS build

ARG ARCH
ENV ARCH=$ARCH
ARG TAG
ENV TAG=$TAG

RUN apk add wget bash gcc musl-dev linux-headers make
ADD build.sh /build/build.sh
RUN /build/build.sh


FROM scratch AS export
COPY --from=build /e2fsprogs.tar.gz .