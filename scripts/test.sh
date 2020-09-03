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

echo "***** Setup conda *****"
bash R

echo "***** Print conda info *****"
conda info

echo "***** Run conda update *****"
conda update --all -y

echo "***** Python path *****"
python -c "import sys; print(sys.executable)"
python -c "import sys; assert 'minirhumba' in sys.executable"

echo "***** Print system informations from Python *****"
python -c "print('Hello minirhumba !')"
python -c "import platform; print(platform.architecture())"
python -c "import platform; print(platform.system())"
python -c "import platform; print(platform.machine())"
python -c "import platform; print(platform.release())"

echo "***** Done: Building Testing installer *****"
