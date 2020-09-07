#!/bin/bash

set -e
set -x

echo "Installing a fresh version of rhumba."
MINIRHUMBA_URL="https://github.com/TheSnakePit/minirhumba/releases/download/0.0.1"
MINIRHUMBA_FILE="minirhumba-0.0.1-MacOSX-x86_64.sh"

curl -L -O "${MINIRHUMBA_URL}/${MINIRHUMBA_FILE}"
bash $MINIRHUMBA_FILE -b

export CONSTRUCT_ROOT=$PWD
mkdir -p build

bash scripts/build.sh
bash scripts/test.sh
