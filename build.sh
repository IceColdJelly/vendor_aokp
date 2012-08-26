export USE_CCACHE=1
export CCACHE_DIR=/$HOME/.ccache
prebuilts/misc/linux-x86/ccache/ccache -M 40G
source build/envsetup.sh
brunch aokp_endeavoru-userdebug
