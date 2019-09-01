#import "_Pr0_Utils.h"


NSString* F_prefGet(NSString *key) {
    return [[NSDictionary dictionaryWithContentsOfFile:MACRO_PLIST] valueForKey:key];
}


bool F_prefGetBool(NSString *key) {
    return [F_prefGet(key) boolValue];
}


void F_presentAlert(UIAlertController* alert, BOOL animated) {
    UIWindow* topWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    topWindow.rootViewController = [UIViewController new];
    topWindow.windowLevel = UIWindowLevelAlert + 1;
    [topWindow makeKeyAndVisible];
    [topWindow.rootViewController presentViewController:alert animated:animated completion:^{
        [topWindow release]; 
    }];
}


void F_simpleAlert(NSString* title, NSString* message) {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:closeAction];
    
    F_presentAlert(alert, true);
}


void F_logEnabling(NSString* message) {
    NSLog(@"[BetterW] -> Enabling:  -%@-", message);
}


bool F_JIDIsGroup(NSString* contactJID) {
    return [contactJID rangeOfString:@"-"].location != NSNotFound;
}


UIView * F_getTopView() {
    return [[[[UIApplication sharedApplication] keyWindow] subviews] lastObject];
}


void F_tryDeleteFile(NSString* filePath) {
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}


WAUserJID* F_userJIDFromString(NSString* jidString) {
    WAUserJID* userJID = [NSClassFromString(@"WAUserJID") withStringRepresentation:jidString];
    return userJID;
}


bool F_isJidOnline(WAUserJID* jid) {
    WAContextMain* context = [NSClassFromString(@"WAContextMain") sharedContext];
    XMPPConnectionMain* connection = [context xmppConnectionMain];
	XMPPPresenceController* presence = [connection presenceController];

    [presence subscribeToJIDIfNecessary:jid];
	return [presence isUserOnline:jid];
}


bool F_isJidOnline(NSString* stringJid) {
    return F_isJidOnline(F_userJIDFromString(stringJid));
}


UIColor* F_UIColorFromNSString(NSString* asString) {
    // Keep the keys lowercase.
    NSDictionary* stringColor = @{
        @"black": [UIColor blackColor],
        @"blue": [UIColor blueColor],
        @"brown": [UIColor brownColor],
        @"clear": [UIColor clearColor],
        @"cyan": [UIColor cyanColor],
        @"darkgray": [UIColor darkGrayColor],
        @"gray": [UIColor grayColor],
        @"green": [UIColor greenColor],
        @"lightgray": [UIColor lightGrayColor],
        @"magenta": [UIColor magentaColor],
        @"orange": [UIColor orangeColor],
        @"purple": [UIColor purpleColor],
        @"red": [UIColor redColor],
        @"white": [UIColor whiteColor],
        @"yellow": [UIColor yellowColor],
    };
    // May return null.
    return [stringColor objectForKey:[asString lowercaseString]];
}
