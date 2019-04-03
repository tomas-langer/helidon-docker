#!/bin/sh

# get the directory of this script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

source ${DIR}/build-native.properties

IMAGE_NAME="helidon/java-native:${IMAGE_VERSION}"

if docker pull ${IMAGE_NAME} ; then
   echo ${native_image} already exists, skipping native build
   exit 0
fi

# Build arguments are loaded from build-native.properties
BUILD_ARGS="--build-arg GRAAL_VERSION=${GRAAL_VERSION}"

DOCKER_ARGS="build -f ${DIR}/Dockerfile -t ${IMAGE_NAME} ${BUILD_ARGS} ${DIR}"

echo "Building native image with arg line: ${DOCKER_ARGS}"

docker ${DOCKER_ARGS}

echo "${IMAGE_NAME}"
