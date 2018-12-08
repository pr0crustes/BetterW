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


void FUNCTION_simpleAlert(NSString* title, NSString* message) {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:closeAction];
    
    FUNCTION_presentAlert(alert, true);
}


void FUNCTION_logEnabling(NSString* message) {
    NSLog(@"[BetterW] -> Enabling:  -%@-", message);
}


bool FUNCTION_contactIsGroup(NSString* contactJID) {
    return [contactJID rangeOfString:@"-"].location != NSNotFound;
}


UIView * FUNCTION_getTopView() {
    return [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
}
