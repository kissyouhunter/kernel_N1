#!/bin/bash
ARG1=$1
ROOT_DIR="/tmp/ramfs"
BUILD_DIR="$ROOT_DIR/build"
SRCURL="https://github.com/kissyouhunter/$REPO"
CONFIG="https://raw.githubusercontent.com/kissyouhunter/kernel_N1/main/.config"
KVERV="5.15.7"

if [ ! -z "$ARG1" ]; then
KVERV=$ARG1
fi

KVER="linux-$KVERV"
KURL="https://cdn.kernel.org/pub/linux/kernel/v5.x"
KDURL="$KURL/$KVER.tar.xz"

if [ ! -d "$ROOT_DIR" ];then
mkdir -p $ROOT_DIR
fi

if [ -d "$BUILD_DIR" ];then
umount $ROOT_DIR
fi

sudo mount -t tmpfs -o size=6G tmpfs $ROOT_DIR
mkdir $BUILD_DIR
cd $BUILD_DIR

wget $KDURL
xz -d "$KVER.tar.xz"
tar xf "$KVER.tar" && rm "$KVER.tar"
cd "$BUILD_DIR/$KVER"
#curl -o .config https://github.com/SuzukiHonoka/s905d-kernel-precompiled/raw/master/.config
