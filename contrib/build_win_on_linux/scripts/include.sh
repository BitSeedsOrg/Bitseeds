#!/bin/bash
export STAGING=$HOME/bitseeds_build/bitseeds_staging
export OUTDIR=$HOME/bitseeds_build/bitseeds_out
export DEPSDIRT=$HOME/bitseeds_build/bitseeds_deps
export HOST=i686-w64-mingw32
export MAKEOPTS="-j4"                           # set to the number of cores you have on the machine
                                                        # divide by two if you have hyperthreading

