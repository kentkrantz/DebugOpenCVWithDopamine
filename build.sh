#!/bin/bash

set -e

# For issue: "od: stdout: Illegal byte sequence"
export LC_ALL=C

export THEOS_DEVICE_IP=192.168.50.28
export THEOS_PACKAGE_SCHEME=rootless
export THEOS_PACKAGE_INSTALL_PREFIX=/var/jb

# sudo xcode-select -s /Applications/Xcode-14.3.1.app

# Build opencv2.framework
# cd vendor
# ./build_opencv.sh
# cd ..

make package
make install