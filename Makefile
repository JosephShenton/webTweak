INSTALL_TARGET_PROCESSES = SpringBoard Safari

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = webTweak

webTweak_FILES = Tweak.x
webTweak_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
