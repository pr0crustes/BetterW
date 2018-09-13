#import "_Pr0_Utils.h"


NSString* FUNCTION_prefGet(NSString *key) {
    return [[NSDictionary dictionaryWithContentsOfFile:MACRO_PLIST] valueForKey:key];
}

bool FUNCTION_prefGetBool(NSString *key) {
    return [FUNCTION_prefGet(key) boolValue];
}
