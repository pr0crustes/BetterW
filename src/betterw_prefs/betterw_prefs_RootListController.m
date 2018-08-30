#include "betterw_prefs_RootListController.h"

@implementation betterw_prefs_RootListController

	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
		}

		return _specifiers;
	}

	-(void)onClickSourceCode:(id)arg1 {
		NSURL *url = [NSURL URLWithString:@"https://github.com/pr0crustes/BetterW"];
		[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
	}

@end
