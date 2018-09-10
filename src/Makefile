# For deploy
# TARGET = iphone:clang
TARGET = iphone:11.2:10.0
FINALPACKAGE = 1
# end deploy

# For simulator
# TARGET = simulator:clang::7.0
# ARCHS = x86_64
# end simulator

# Needed to 'make package install'
THEOS_DEVICE_IP = 192.168.1.6

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = betterW
betterW_FILES = $(wildcard tweak/*.xm)

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += betterw_prefs
include $(THEOS_MAKE_PATH)/aggregate.mk

# Just to quick delete files
remove::
	@rm -r .theos
	@rm -r obj
	@rm -r packages
