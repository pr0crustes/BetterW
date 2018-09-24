#import <UIKit/UIKit.h>
/**
    File that aggregate macros and functions.
    Macros are your friend, no need to hate them, but never overuse.
*/

// Quick way to get the plist
#define MACRO_PLIST @"/var/mobile/Library/Preferences/me.pr0crustes.betterw_prefs.plist"


// Macro to Log enabling
#define MACRO_log_enabling(message) NSLog(@"[BetterW] -> Enabling:  -%@-", message)


// A simple macro to check if a contactJID is from a group
#define MACRO_is_contactJID_group(contactJID) ([contactJID rangeOfString:@"-"].location != NSNotFound)


// Functions to load preferences
NSString* FUNCTION_prefGet(NSString *key);
bool FUNCTION_prefGetBool(NSString *key);

// Function to present an alert from anywhere
void FUNCTION_presentAlert(UIAlertController* alert, BOOL animated);
