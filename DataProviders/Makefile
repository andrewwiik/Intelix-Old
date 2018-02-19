ifeq ($(SIMULATOR),1)
	export TARGET = simulator:clang:latest
	export ARCHS = x86_64
else
	export TARGET = iphone:latest
	export ARCHS = armv7 arm64
endif

include $(THEOS)/makefiles/common.mk

export ADDITIONAL_CFLAGS = -I./../../headers -I./../../

SUBPROJECTS += MobileMail
SUBPROJECTS += News
include $(THEOS_MAKE_PATH)/aggregate.mk
