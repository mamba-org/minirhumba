#!/usr/bin/env bash

set -xe

echo "***** Start: Building minirhumba installer *****"

CONSTRUCT_ROOT="${CONSTRUCT_ROOT:-$PWD}"

cd $CONSTRUCT_ROOT

# Constructor should be latest for non-native building
# See https://github.com/conda/constructor
echo "***** Install constructor *****"
conda install mamba -c conda-forge
mamba install -y "constructor>=3.1.0" jinja2 -c conda-forge -c defaults --override-channels
if [[ "$(uname)" == "Darwin" ]]; then
    mamba install -y coreutils -c conda-forge -c defaults --override-channels
elif [[ "$(uname)" == MINGW* ]]; then
    mamba install -y "nsis=3.01" -c conda-forge -c defaults --override-channels
fi
pip install git+git://github.com/conda/constructor@8c0121d3b81846de42973b52f13135f0ffeaddda#egg=constructor --force --no-deps
mamba list

echo "***** Make temp directory *****"
if [[ "$(uname)" == MINGW* ]]; then
   TEMP_DIR=$(mktemp -d --tmpdir=C:/Users/RUNNER~1/AppData/Local/Temp/);
else
   TEMP_DIR=$(mktemp -d);
fi

echo "***** Copy file for installer construction *****"
cp -R minirhumba $TEMP_DIR/
cp LICENSE $TEMP_DIR/

ls -al $TEMP_DIR

if [[ $(uname -r) != "$ARCH" ]]; then
    if [[ "$ARCH" == "arm64" ]]; then
        CONDA_SUBDIR=osx-arm64 mamba create -n micromamba micromamba=0.11.3 -c conda-forge --yes
        EXTRA_CONSTRUCTOR_ARGS="$EXTRA_CONSTRUCTOR_ARGS --conda-exe $CONDA_PREFIX/envs/micromamba/bin/micromamba --platform osx-arm64"
    fi
fi

echo "***** Construct the installer *****"
constructor $TEMP_DIR/minirhumba/ --output-dir $TEMP_DIR $EXTRA_CONSTRUCTOR_ARGS

echo "***** Generate installer hash *****"
cd $TEMP_DIR
if [[ "$(uname)" == MINGW* ]]; then
   EXT=exe;
else
   EXT=sh;
fi
# This line will break if there is more than one installer in the folder.
INSTALLER_PATH=$(find . -name "minirhumba*.$EXT" | head -n 1)
HASH_PATH="$INSTALLER_PATH.sha256"
sha256sum $INSTALLER_PATH > $HASH_PATH

echo "***** Move installer and hash to build folder *****"
mkdir -p $CONSTRUCT_ROOT/build
mv $INSTALLER_PATH $CONSTRUCT_ROOT/build/
mv $HASH_PATH $CONSTRUCT_ROOT/build/

echo "***** Done: Building minirhumba installer *****"
cd $CONSTRUCT_ROOT