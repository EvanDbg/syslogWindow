ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ELogWindow
ELogWindow_FILES = code/Tweak.xm code/ELogWindow.m
ELogWindow_FRAMEWORKS = CoreGraphics UIKit QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
