ARCHS = armv7 arm64
TARGET = iphone:clang:latest:latest
THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TWEAK_NAME = SwipeFolder
SwipeFolder_FILES = Tweak.xm
SwipeFolder_FRAMEWORKS = UIKit
SwipeFolder_FRAMEWORKS += CoreGraphics
SwipeFolder_FRAMEWORKS += QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
