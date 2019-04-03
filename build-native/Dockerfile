FROM openjdk:8-jdk-slim as build
LABEL maintainer="tomas.langer@oracle.com"
ARG GRAAL_VERSION
ARG JVMCI_VERSION

# TODO try to download binary distribution?
https://github.com/oracle/graal/releases/download/vm-1.0.0-rc13/graalvm-ce-1.0.0-rc13-linux-amd64.tar.gz

RUN set -x \
    && apt-get -y update \
    && apt-get -y install gcc g++ git make openjdk-8-doc openjdk-8-source python zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# This could be a separate image - the command above takes a very long time and should not be re-done every time
WORKDIR /build

RUN set -x \
    && git clone https://github.com/graalvm/mx.git \
    && git clone https://github.com/graalvm/graal-jvmci-8.git -b $JVMCI_VERSION --single-branch \
    && mx/mx --primary-suite graal-jvmci-8 --vm=server build -DFULL_DEBUG_SYMBOLS=0 \
    && mx/mx --primary-suite graal-jvmci-8 --vm=server -v vm -version \
    && mx/mx --primary-suite graal-jvmci-8 --vm=server -v unittest \
    && cp -r $(/build/mx/mx --primary-suite graal-jvmci-8 jdkhome) /build/jvmcijdk8

RUN git clone https://github.com/oracle/graal.git -b $GRAAL_VERSION --single-branch
WORKDIR /build/graal/vm
RUN export JAVA_HOME=/build/jvmcijdk8 \
    && /build/mx/mx --dy /substratevm --force-bash-launchers=true --disable-polyglot --disable-libpolyglot build

WORKDIR /build/graal/vm/latest_graalvm
RUN LONG_NAME=$(ls) \
    && SHORT_NAME=graalvm \
    && mv $LONG_NAME $SHORT_NAME

FROM debian:stretch-slim as final
LABEL maintainer="tomas.langer@oracle.com"

RUN set -x \
    && apt-get -y update \
    && apt-get -y install gcc zlib1g-dev

COPY --from=build /build/graal/vm/latest_graalvm/graalvm /usr/local/graalvm

ENV GRAALVM_HOME=/usr/local/graalvm
WORKDIR /helidon
