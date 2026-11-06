export ARCHS = armv7
export TARGET = iphone:clang:latest:6.0

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = Jellyfin
Jellyfin_FILES = main.m AppDelegate.m
Jellyfin_FRAMEWORKS = UIKit Foundation CoreGraphics AVFoundation
Jellyfin_CFLAGS = -fno-objc-arc -Wno-deprecated-declarations

include $(THEOS_MAKE_PATH)/application.mk
