ifeq ($(SIMULATOR),1)
	export TARGET = simulator:clang:latest
	export ARCHS = x86_64
else
	export TARGET = iphone:latest
	export ARCHS = armv7 arm64
endif

INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

# the main bits
SUBPROJECTS += DataProviders
SUBPROJECTS += SpringBoard

include $(THEOS_MAKE_PATH)/aggregate.mk

