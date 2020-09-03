#!/usr/bin/env bash

set -e

echo "***** Start: Building minirhumba installer *****"

CONSTRUCT_ROOT="${CONSTRUCT_ROOT:-/construct}"

cd $CONSTRUCT_ROOT

echo "***** Install constructor *****"
python -m pip install https://github.com/conda/constructor/archive/master.zip

echo "***** Make temp directory *****"
TEMP_DIR=$(mktemp -d)

echo "***** Copy file for installer construction *****"
cp -R minirhumba $TEMP_DIR/
cp LICENSE $TEMP_DIR/

ls -al $TEMP_DIR

echo "***** Construct the installer *****"
constructor $TEMP_DIR/minirhumba/ --output-dir $TEMP_DIR

echo "***** Generate installer hash *****"
cd $TEMP_DIR
# This line ill break if there is more than one installer in the folder.
INSTALLER_PATH=$(find . -name "minirhumba*.sh" | head -n 1)
HASH_PATH="$INSTALLER_PATH.sha256"
sha256sum $INSTALLER_PATH > $HASH_PATH

echo "***** Move installer and hash to build folder *****"
mv $INSTALLER_PATH $CONSTRUCT_ROOT/build/
mv $HASH_PATH $CONSTRUCT_ROOT/build/

echo "***** Done: Building minirhumba installer *****"
