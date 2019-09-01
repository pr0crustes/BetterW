#ifndef _PR0_UTILS_H
#define _PR0_UTILS_H

#import <UIKit/UIKit.h>

#import "headers/WAUserJID.h"
#import "headers/WAContextMain.h"
#import "headers/XMPPConnectionMain.h"
#import "headers/XMPPPresenceController.h"
/**
    File that aggregate macros and functions.
    Macros are your friend, no need to hate them, but never overuse.
*/


// Macros for error codes.
#define PR0CRUSTES_OK (0)
#define PR0CRUSTES_FAIL (-1)
#define PR0CRUSTES_FILE_ERROR (-2)


// Quick way to get the plist
#define MACRO_PLIST @"/var/mobile/Library/Preferences/me.pr0crustes.betterw_prefs.plist"


// Functions to load preferences
NSString* F_prefGet(NSString *key);
bool F_prefGetBool(NSString *key);

// Function to present an alert from anywhere
void F_presentAlert(UIAlertController* alert, BOOL animated);
void F_simpleAlert(NSString* title, NSString* message);

// Function to log the hooks
void F_logEnabling(NSString* message);

// Function to check if given contactJID is a group
bool F_JIDIsGroup(NSString* jid);

// Function to get the view at the top.
UIView * F_getTopView();

// Function that tries to remove a file, ignoring in error case.
void F_tryDeleteFile(NSString* filePath);

// Create a WAUserJID from a NSString.
WAUserJID* F_userJIDFromString(NSString* jidString);

// Returns if user JID is online. Overloaded.
bool F_isJidOnline(WAUserJID* jid);
bool F_isJidOnline(NSString* stringJid);


// Converts a NSString to an UIColor. May return null if argument is invalid.
// Accepted values are: black, blue, brown, clear, cyan, darkgray, gray, green, lightgray, magenta, orange, purple, red, white, yellow.
UIColor* F_UIColorFromNSString(NSString* asString);

#endif
