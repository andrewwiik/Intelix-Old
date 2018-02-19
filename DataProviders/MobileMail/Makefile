include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ITXMobileMailProvider
ITXMobileMailProvider_BUNDLE_NAME = ITXMobileMailProvider
ITXMobileMailProvider_BUNDLE_EXTENSION = bundle
ITXMobileMailProvider_CFLAGS =  -fobjc-arc
ITXMobileMailProvider_FILES = $(wildcard *.m) $(wildcard *.xm)
ITXMobileMailProvider_FRAMEWORKS = Foundation
ITXMobileMailProvider_LDFLAGS += $(THEOS)/vendor/lib/libsubstrate.tbd
ITXMobileMailProvider_INSTALL_PATH = /Library/Intelix/DataProviders/
ITXMobileMailProvider_LDFLAGS += -F../../.theos/$(THEOS_OBJ_DIR_NAME) ./Message.tbd


include $(THEOS_MAKE_PATH)/bundle.mk
