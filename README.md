# DebugOpenCVWithDopamine

## Issue

`OpenCV` functions crash iOS into safe-mode in `Dopamine` jailbroken env, while it works totally well in `palera1n`(both `rootless` and `rootful`) and `unc0ver` and other tools.

## How to start?

1. Install `NSLogger` on desktop to view the logs: <https://github.com/fpillet/NSLogger> .

2. Build and install

```sh
# Clone submodules' code
git submodule update --init --recursive

# Enter dir vendor
cd vendor

# build opencv2.framework
./build_opencv.sh

# Back to project root dir
cd ..

# cp .env.example to .env
# And set the target device IP to `THEOS_DEVICE_IP`

# Build and install the tweak
./build.sh
```

3. Press volume up button to trigger the testing.
