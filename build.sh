#!/bin/bash

# build script for endeavoru

# Text color variables
txtund=$(tput sgr 0 1)          # Underline
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldylw=${txtbld}$(tput setaf 3) #  yellow
bldblu=${txtbld}$(tput setaf 4) #  blue
bldmag=${txtbld}$(tput setaf 5) #  magenta
bldcya=${txtbld}$(tput setaf 6) #  cyan
bldwht=${txtbld}$(tput setaf 7) #  white
txtrst=$(tput sgr0)             # Reset
info=${bldwht}*${txtrst}        # Feedback
pass=${bldblu}*${txtrst}
warn=${bldred}*${txtrst}
ques=${bldblu}?${txtrst}


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

    finish="$(tput setaf 5)\n\n\nIceColdJelly V$1 compiled for your flashing pleasure!!!\n\n\n$(tput sgr0)"
    printf "$finish"
else
    finish="$(tput setaf 5)\n\n\nIceColdJelly unofficial compiled for your flashing pleasure!!!\n\nNOW...\nFLASH\nFLASH\nFLASH!!!\n$(tput sgr0)"
    printf "$finish"
fi
