#!/usr/bin/env bash

set -e

echo "***** Start: Testing minirhumba installer *****"

export RHUMBA_PATH="$HOME/minirhumba"

CONSTRUCT_ROOT="${CONSTRUCT_ROOT:-/construct}"

cd ${CONSTRUCT_ROOT}

echo "***** Get the installer *****"
INSTALLER_PATH=$(find build/ -name "minirhumba*$ARCH.sh" | head -n 1)

echo "***** Run the installer *****"
chmod +x $INSTALLER_PATH
bash $INSTALLER_PATH -b -p $RHUMBA_PATH

echo "***** Done: Building Testing installer *****"
