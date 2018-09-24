#import "_Pr0_Utils.h"


NSString* FUNCTION_prefGet(NSString *key) {
    return [[NSDictionary dictionaryWithContentsOfFile:MACRO_PLIST] valueForKey:key];
}


bool FUNCTION_prefGetBool(NSString *key) {
    return [FUNCTION_prefGet(key) boolValue];
}


void FUNCTION_presentAlert(UIAlertController* alert, BOOL animated) {
    UIWindow* topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
    [topWindow makeKeyAndVisible];
    [topWindow.rootViewController presentViewController:alert animated:animated completion:^{
        [topWindow release]; 
    }];
}
