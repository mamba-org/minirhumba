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
  source $CONDA_PATH/Scripts/activate

  Rscript -e "rhumba::set_config('auto_yes', 'true'); rhumba::install('xtensor')"

  test -d $CONDA_PATH/Library/include/xtensor
  test -f $CONDA_PATH/Library/include/xtensor/xtensor.hpp
else
  bash $INSTALLER_PATH -b -p $RHUMBA_PATH
  source $CONDA_PATH/bin/activate

  Rscript -e "rhumba::set_config('auto_yes', 'true'); rhumba::install('xtensor')"

  test -d $CONDA_PATH/include/xtensor
  test -f $CONDA_PATH/include/xtensor/xtensor.hpp
fi

echo "***** Done: Testing installer *****"