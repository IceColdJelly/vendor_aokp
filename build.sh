#!/bin/bash

# build script for endeavoru
# $1 should be build number

export USE_CCACHE=1
export CCACHE_DIR=/$HOME/.ccache
prebuilts/misc/linux-x86/ccache/ccache -M 40G

source build/envsetup.sh && lunch aokp_endeavoru-userdebug
schedtool -B -n 1 -e ionice -n 1 make -j `cat /proc/cpuinfo | grep "^processor" | wc -l` bacon 2>&1

if [ "$1" != "" ]; then
    ZIP=`find ${ANDROID_PRODUCT_OUT}/ . -maxdepth 1 -name '*.zip' -mtime -1 | xargs stat --format '%n' | sort -nr | cut -d: -f2- | head -1`
    if [ ! -f "$ZIP" ]; then
      echo "Error: no output .zip found on ${ANDROID_PRODUCT_OUT}"
      exit 1
    fi
    mv -f ${ZIP} ${ANDROID_PRODUCT_OUT}/aokp_endeavoru-ICJ-V"$1".zip

    SUM=`find ${ANDROID_PRODUCT_OUT}/ . -maxdepth 1 -name '*.md5sum' -mtime -1 | xargs stat --format '%n' | sort -nr | cut -d: -f2- | head -1`
    if [ ! -f "$SUM" ]; then
      echo "Error: no output .md5sum found on ${ANDROID_PRODUCT_OUT}"
      exit 2
    fi
    mv -f ${SUM} ${ANDROID_PRODUCT_OUT}/aokp_endeavoru-ICJ-V"$1".zip.md5sum

    finish="\n\n\nIceColdJelly V$1 compiled for your flashing pleasure!!!\n\n\n"
    printf "$finish"
else
    finish="\n\n\nIceColdJelly unofficial compiled for your flashing pleasure!!!\n\nNOW...\nFLASH\nFLASH\nFLASH!!!\n"
    printf "$finish"
fi
