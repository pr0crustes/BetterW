#import "_Pr0_Utils.h"


NSString* FUNCTION_prefGet(NSString *key) {
    return [[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/me.pr0crustes.betterw_prefs.plist"] valueForKey:key];
}

bool FUNCTION_prefGetBool(NSString *key) {
    return [FUNCTION_prefGet(key) boolValue];
}
