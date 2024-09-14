# DebugOpenCVWithDopamine

## How to start?

1. Install `NSLogger` on desktop to view the logs: https://github.com/fpillet/NSLogger . 

2. Build

```sh
# Clone submodules' code
git submodule update --init --recursive

# Enter dir vendor
cd vendor

# build opencv2.framework
./build_opencv.sh

# Back to project root dir
cd ..

# Build and install the tweak
# You may need to modify the target device IP in `build.sh`
./build.sh
```
