#!/bin/bash
# create multiresolution windows icon
ICON_DST=../../src/qt/res/icons/BitSeeds.ico

convert ../../src/qt/res/icons/BitSeeds-16.png ../../src/qt/res/icons/BitSeeds-32.png ../../src/qt/res/icons/BitSeeds-48.png ${ICON_DST}
