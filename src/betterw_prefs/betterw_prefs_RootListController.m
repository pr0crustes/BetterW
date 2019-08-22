#include "betterw_prefs_RootListController.h"


@implementation betterw_prefs_RootListController

	- (NSArray *)specifiers {
		if (!_specifiers) {
			_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
		}

		return _specifiers;
	}

	-(void)onClickBitcoinAddress:(id)arg1 {
		UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
		pasteboard.string = @"1CvcFZAMpzWzhPQzQ6vZdejSwTNuwWrPy5";
	}

	// Just a button that opens the project on github.
	-(void)onClickSourceCode:(id)arg1 {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/pr0crustes/BetterW"] options:@{} completionHandler:nil];
	}

	// Just a button to respring, restarting whatsapp
	- (void)respring:(id)arg1 {
		pid_t pid;
		int status;
		const char* argv[] = {"killall", "SpringBoard", NULL};
		posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)argv, NULL);
		waitpid(pid, &status, WEXITED);
	}

@end
