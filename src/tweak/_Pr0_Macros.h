/**
    File that aggregate macros.
    Macros are your friend, no need to hate them, but never overuse.
*/


// Macro to load preferences
#define MACRO_pref_get_bool(key) [[[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/me.pr0crustes.betterw_prefs.plist"] valueForKey:key] boolValue]


// Macro to Log enabling
#define MACRO_log_enabling(message) NSLog(@"[BetterW] -> Enabling:  -%@-", message)


// A simple macro to bring back what was once UIAlert, helps to reduce code repetition
#define MACRO_present_alert_with(presentView, handlerYes, handlerNo) \
{ \
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to call?" preferredStyle:UIAlertControllerStyleAlert]; \
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { handlerYes }]; \
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {handlerNo }]; \
    [alert addAction:yesAction]; \
    [alert addAction:noAction]; \
    [presentView presentViewController:alert animated:YES completion:nil]; \
}


// A simple macro to check if a contactJID is from a group
#define MACRO_is_contactJID_group(contactJID) ([contactJID rangeOfString:@"-"].location != NSNotFound)
