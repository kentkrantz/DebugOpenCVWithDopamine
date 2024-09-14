#!/bin/sh

set -e

# https://www.notion.so/kvzn/Build-opencv-v4-for-iOS-7402c67787fa463fbe680a14c7ced308?pvs=4#54d756a0723840b485e1bedd87985601
export OPENCV_SKIP_XCODEBUILD_FORCE_TRYCOMPILE_DEBUG=1

TARGET_DIR=opencv_build_ios

# python opencv/platforms/ios/build_framework.py ${TARGET_DIR} \
#     --contrib opencv_contrib \
#     --iphoneos_archs arm64,arm64e \
#     --iphoneos_deployment_target 12.0 \
#     --build_only_specified_archs \
#     --disable-swift \
#     --enable_nonfree

python opencv/platforms/ios/build_framework.py ${TARGET_DIR} \
    --iphoneos_archs arm64,arm64e \
    --iphoneos_deployment_target 14.0 \
    --build_only_specified_archs \
    --debug \
    --debug-info

rm -rf ../frameworks/opencv2.framework
cp -r ${TARGET_DIR}/opencv2.framework ../frameworks/