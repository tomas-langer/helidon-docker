FROM debian:stretch-slim as final
LABEL maintainer="tomas.langer@oracle.com"
# 1.0.0-rc13
# ARG GRAAL_VERSION

# ARG FILE="graalvm-ce-$GRAAL_VERSION-linux-amd64.tar"
# ARG GZIP="$FILE.gz"
# ARG LINK="https://github.com/oracle/graal/releases/download/vm-$GRAAL_VERSION/$GZIP"

RUN set -x \
    && apt-get -y update \
    && apt-get -y install gcc zlib1g-dev

WORKDIR /graal

# wget --no-verbose $LINK \
#   && gunzip $GZIP
#   && tar -xvf $FILE
#   && rm $FILE
ADD graalvm-ce-1.0.0-rc13-linux-amd64.tar.gz /graal

RUN LONG_NAME=$(ls) \
    && SHORT_NAME=graalvm \
    && mv $LONG_NAME $SHORT_NAME

ENV GRAALVM_HOME=/graal/graalvm
