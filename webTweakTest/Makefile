INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = webTweakTest

webTweakTest_FILES = Tweak.x
webTweakTest_CFLAGS = -fobjc-arc
export ARCHS = armv7 armv7s arm64 arm64e

include $(THEOS_MAKE_PATH)/tweak.mk
