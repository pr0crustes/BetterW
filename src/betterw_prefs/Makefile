include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = betterw_prefs
betterw_prefs_FILES = betterw_prefs_RootListController.m
betterw_prefs_INSTALL_PATH = /Library/PreferenceBundles
betterw_prefs_FRAMEWORKS = UIKit
betterw_prefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/betterw_prefs.plist$(ECHO_END)
