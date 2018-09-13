#import <UIKit/UIKit.h>
/**
    File that aggregate macros and functions.
    Macros are your friend, no need to hate them, but never overuse.
*/

// Quick way to get the plist
#define MACRO_PLIST @"/var/mobile/Library/Preferences/me.pr0crustes.betterw_prefs.plist"


// Macro to Log enabling
#define MACRO_log_enabling(message) NSLog(@"[BetterW] -> Enabling:  -%@-", message)


// A simple macro to bring back what was once UIAlert, helps to reduce code repetition
#define MACRO_present_alert_with(presentView, handlerYes, handlerNo) \
{ \
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to call?" preferredStyle:UIAlertControllerStyleAlert]; \
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { handlerYes }]; \
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { handlerNo }]; \
    [alert addAction:yesAction]; \
    [alert addAction:noAction]; \
    [presentView presentViewController:alert animated:YES completion:nil]; \
}


// A simple macro to check if a contactJID is from a group
#define MACRO_is_contactJID_group(contactJID) ([contactJID rangeOfString:@"-"].location != NSNotFound)


// Functions to load preferences
NSString* FUNCTION_prefGet(NSString *key);
bool FUNCTION_prefGetBool(NSString *key);
