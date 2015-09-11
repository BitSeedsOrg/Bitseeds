#!/bin/bash
set -e

export STAGING=$HOME/bitseeds_build/bitseeds_staging
export OUTDIR=$HOME/bitseeds_build/bitseeds_out
export DEPSDIRT=$HOME/bitseeds_build/bitseeds_deps
export HOST=i686-w64-mingw32
export MAKEOPTS="-j4"                           # set to the number of cores you have on the machine

# installer
cd $DEPSDIRT/bitseeds
rm -rf nsis
mkdir nsis
git archive HEAD | tar -x -C nsis
cd nsis/src
mkdir ../release
cp ../../release/* ../release/
cp ../../src/*.exe .
cp ../../share/*.dll ../release
makensis ../share/setup.nsi
rm -rf $OUTDIR/setup
mkdir $OUTDIR/setup
cp ../share/bitseeds-*-win32.exe $OUTDIR/setup/

# results
cd $OUTDIR
rm -rf bitseeds-dist.zip
zip -r bitseeds-dist.zip setup client daemon

echo -e "\n\n"
echo "Results are in $OUTDIR/bitseeds-dist.zip"
echo -e "\n"


