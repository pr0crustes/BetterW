#ifndef _PR0_UTILS_H
#define _PR0_UTILS_H

#import <UIKit/UIKit.h>

#import "headers/WAUserJID.h"
#import "headers/WAContextMain.h"
#import "headers/XMPPConnectionMain.h"
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
NSString* FUNCTION_prefGet(NSString *key);
bool FUNCTION_prefGetBool(NSString *key);

// Function to present an alert from anywhere
void FUNCTION_presentAlert(UIAlertController* alert, BOOL animated);
void FUNCTION_simpleAlert(NSString* title, NSString* message);

// Function to log the hooks
void FUNCTION_logEnabling(NSString* message);

// Function to check if given contactJID is a group
bool FUNCTION_JIDIsGroup(NSString* JIDJID);

// Function to get the view at the top.
UIView * FUNCTION_getTopView();

// Function that tries to remove a file, ignoring in error case.
void FUNCTION_tryDeleteFile(NSString* filePath);

// Create a WAUserJID from a NSString.
WAUserJID* FUNCTION_userJIDFromString(NSString* jidString);

// Returns if user JID is online. Overloaded.
bool FUNCTION_isJidOnline(WAUserJID* jid);
bool FUNCTION_isJidOnline(NSString* stringJid);

#endif
