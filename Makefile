THEOS = ./vendor/theos
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:14.0

include $(THEOS)/makefiles/common.mk

#=======================================
TWEAK_NAME = DebugOpenCVWithDopamine

DebugOpenCVWithDopamine_FILES = \
		src/TestOpenCV.mm \
		src/Tweak.xm \
		src/Test.swift

DebugOpenCVWithDopamine_FRAMEWORKS = Foundation CoreFoundation IOKit MobileCoreServices CoreGraphics UIKit CoreLocation CoreML

DebugOpenCVWithDopamine_EXTRA_FRAMEWORKS = opencv2 NSLogger

 # https://github.com/theos/theos/releases
DebugOpenCVWithDopamine_CFLAGS += \
		-fobjc-arc \
		-fdata-sections -ffunction-sections \
		-F./frameworks \
		-Wno-nullability-completeness \
		-Wno-incomplete-umbrella \
		-DTHEOS_LEAN_AND_MEAN

DebugOpenCVWithDopamine_CXXFLAGS += \
		-std=c++11 \
		-stdlib=libc++ \
		-I/usr/include/c++/v1

src/Tweak.xm_CFLAGS = $(DebugOpenCVWithDopamine_CXXFLAGS)
src/TestOpenCV.mm_CFLAGS = $(DebugOpenCVWithDopamine_CXXFLAGS)

# Macro CV_INLINE of opencv conflict with CV_INLINE of CoreVideo.framework
# src/TestOpenCV.mm_CFLAGS += -Wno-ambiguous-macro

DebugOpenCVWithDopamine_LDFLAGS += \
		-F./frameworks \
		-lc++ \
		-lc++abi # Add this line to link the C++ ABI library

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "launchctl stop com.apple.SpringBoard"