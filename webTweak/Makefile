INSTALL_TARGET_PROCESSES = SpringBoard Safari

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = webTweak

$(TWEAK_NAME)_FILES = Tweak.x $(wildcard Extra/*.m)
$(TWEAK_NAME)_CFLAGS = -fobjc-arc
$(TWEAK_NAME)_FRAMEWORKS = CoreServices SafariServices
# $(TWEAK_NAME)_PRIVATE_FRAMEWORKS = FrontBoard FrontBoardServices

include $(THEOS_MAKE_PATH)/tweak.mk
