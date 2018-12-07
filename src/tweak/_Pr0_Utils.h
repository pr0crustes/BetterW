#import <UIKit/UIKit.h>
/**
    File that aggregate macros and functions.
    Macros are your friend, no need to hate them, but never overuse.
*/

// Quick way to get the plist
#define MACRO_PLIST @"/var/mobile/Library/Preferences/me.pr0crustes.betterw_prefs.plist"


// Functions to load preferences
NSString* FUNCTION_prefGet(NSString *key);
bool FUNCTION_prefGetBool(NSString *key);

// Function to present an alert from anywhere
void FUNCTION_presentAlert(UIAlertController* alert, BOOL animated);

// Function to log the hooks
void FUNCTION_logEnabling(NSString* message);

// Function to check if given contactJID is a group
bool FUNCTION_contactIsGroup(NSString* contactJID);

// Function to get the view at the top.
UIView * FUNCTION_getTopView();

