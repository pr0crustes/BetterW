#include "betterw_prefs_RootListController.h"

@implementation betterw_prefs_RootListController

	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
		}

		return _specifiers;
	}

	// Just a button that opens the project on github.
	-(void)onClickSourceCode:(id)arg1 {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/pr0crustes/BetterW"] options:@{} completionHandler:nil];
	}

@end
