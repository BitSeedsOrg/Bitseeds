#!/bin/bash
export STAGING=$HOME/bitseeds_build/bitseeds_staging
export OUTDIR=$HOME/bitseeds_build/bitseeds_out
export DEPSDIRT=$HOME/bitseeds_build/bitseeds_deps
export HOST=i686-w64-mingw32
export MAKEOPTS="-j4"                           # set to the number of cores you have on the machine


set -e

rm -rf $DEPSDIRT $OUTDIR $STAGING $HOME/qt

sudo apt-get install -y mingw-w64 g++-mingw-w64 faketime zip build-essential psmisc nsis git

mkdir -p $DEPSDIRT $OUTDIR $STAGING

