#!/usr/bin/env bash

set -ex

echo "***** Start: Testing minirhumba installer *****"

export RHUMBA_PATH="$HOME/minirhumba"

CONSTRUCT_ROOT="${CONSTRUCT_ROOT:-$PWD}"

cd ${CONSTRUCT_ROOT}

echo "***** Get the installer *****"
ls build/
if [[ "$(uname)" == MINGW* ]]; then
   EXT=exe;
else
   EXT=sh;
fi
INSTALLER_PATH=$(find build/ -name "minirhumba*.$EXT" | head -n 1)

echo "***** Run the installer *****"
chmod +x $INSTALLER_PATH
if [[ "$(uname)" == MINGW* ]]; then
  echo "start /wait \"\" ${INSTALLER_PATH} /InstallationType=JustMe /RegisterPython=0 /S /D=$(cygpath -w $RHUMBA_PATH)" > install.bat
  cmd.exe /c install.bat
else
  bash $INSTALLER_PATH -b -p $RHUMBA_PATH
fi

echo "***** Done: Testing installer *****"