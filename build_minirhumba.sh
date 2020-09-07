#!/usr/bin/env bash

set -e

# Check parameters
ARCH=${ARCH:-aarch64}
DOCKER_ARCH=${DOCKER_ARCH:arm64v8}
DOCKERIMAGE=${DOCKERIMAGE:-condaforge/linux-anvil-aarch64}

echo "============= Create build directory ============="
mkdir -p build/
chmod 777 build/
ls

echo "============= Enable QEMU ============="
docker run --rm --privileged multiarch/qemu-user-static:register --reset --credential yes

echo "============= Install dependencies ============="
echo "Installing a fresh version of Miniforge3 to build the rhumba environment."
MINIFORGE_URL="https://github.com/conda-forge/miniforge/releases/download/4.8.3-1"
MINIFORGE_FILE="Miniforge3-4.8.3-1-MacOSX-x86_64.sh"

curl -L -O "${MINIFORGE_URL}/${MINIFORGE_FILE}"
bash $MINIFORGE_FILE -b

echo "Configuring conda."
source ~/miniforge3/bin/activate root

echo "============= Build the installer ============="
docker run --rm -ti -v $(pwd):/construct -e MINIFORGE_VERSION -e MINIFORGE_NAME $DOCKERIMAGE /construct/scripts/build.sh

echo "============= Download QEMU static binaries ============="
bash scripts/get_qemu.sh

echo "============= Test the installer ============="
for TEST_IMAGE_NAME in "ubuntu:19.10" "ubuntu:16.04" "ubuntu:18.04" "centos:7" "debian:buster"
do
  echo "============= Test installer on $TEST_IMAGE_NAME ============="
  docker run --rm -ti -v $(pwd):/construct -v $(pwd)/build/qemu/qemu-${ARCH}-static:/usr/bin/qemu-${ARCH}-static ${DOCKER_ARCH}/$TEST_IMAGE_NAME /construct/scripts/test.sh
done

