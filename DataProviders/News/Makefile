include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ITXNewsProvider
ITXNewsProvider_BUNDLE_NAME = ITXNewsProvider
ITXNewsProvider_BUNDLE_EXTENSION = bundle
ITXNewsProvider_CFLAGS =  -fobjc-arc
ITXNewsProvider_FILES = $(wildcard *.m) $(wildcard *.xm)
ITXNewsProvider_FRAMEWORKS = Foundation
ITXNewsProvider_LDFLAGS += $(THEOS)/vendor/lib/libsubstrate.tbd
ITXNewsProvider_INSTALL_PATH = /Library/Intelix/DataProviders/
ITXNewsProvider_LDFLAGS += -F../../.theos/$(THEOS_OBJ_DIR_NAME)


include $(THEOS_MAKE_PATH)/bundle.mk

SUBPROJECTS += CloudKitDaemon

include $(THEOS_MAKE_PATH)/aggregate.mk
