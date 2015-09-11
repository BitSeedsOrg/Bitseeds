#!/bin/bash

set -e

export STAGING=$HOME/bitseeds_build/bitseeds_staging
export OUTDIR=$HOME/bitseeds_build/bitseeds_out
export DEPSDIRT=$HOME/bitseeds_build/bitseeds_deps
export HOST=i686-w64-mingw32
export MAKEOPTS="-j4"                           # set to the number of cores you have on the machine
  
cd $STAGING
unzip -o $OUTDIR/qt-win32-4.8.3-gitian-r4.zip
unzip -o $OUTDIR/boost-win32-1.54.0-gitian-r6.zip -d boost
unzip -o $OUTDIR/bitseeds-deps-win32-gitian-r9.zip
cd $DEPSDIRT
rm -rf bitseeds
git clone https://github.com/bitseedsfoundation/bitseeds.git	# or just unpack a .tar archive
cd $DEPSDIRT/bitseeds
export PATH=$STAGING/host/bin:$PATH
ln -sf $STAGING $HOME/qt


# coind
cd src
make -f makefile.linux-mingw clean
make -f makefile.linux-mingw $MAKEOPTS DEPSDIR=$STAGING bitseedsd.exe USE_UPNP=0 DEBUGFLAGS="-frandom-seed=bitseeds" 
$HOST-strip *.exe
rm -rf $OUTDIR/daemon
mkdir $OUTDIR/daemon
cp *.exe $OUTDIR/daemon

# coin qt
cd ..
$STAGING/host/bin/qmake -spec unsupported/win32-g++-cross MINIUPNPC_LIB_PATH=$STAGING/lib MINIUPNPC_INCLUDE_PATH=$STAGING/include BDB_LIB_PATH=$STAGING/lib BDB_INCLUDE_PATH=$STAGING/include BOOST_LIB_PATH=$STAGING/boost/lib BOOST_INCLUDE_PATH=$STAGING/boost/include BOOST_LIB_SUFFIX=-mt-s BOOST_THREAD_LIB_SUFFIX=_win32-mt-s OPENSSL_LIB_PATH=$STAGING/lib OPENSSL_INCLUDE_PATH=$STAGING/include QRENCODE_LIB_PATH=$STAGING/lib QRENCODE_INCLUDE_PATH=$STAGING/include USE_QRCODE=1 INCLUDEPATH=$STAGING/include DEFINES=BOOST_THREAD_USE_LIB BITCOIN_NEED_QT_PLUGINS=1 QMAKE_LRELEASE=lrelease QMAKE_CXXFLAGS=-frandom-seed=bitseeds QMAKE_LFLAGS=-frandom-seed=bitseeds USE_BUILD_INFO=1
make clean
make $MAKEOPTS
$HOST-strip release/*-qt.exe
rm -rf $OUTDIR/client
mkdir $OUTDIR/client
cp release/*-qt.exe $OUTDIR/client
