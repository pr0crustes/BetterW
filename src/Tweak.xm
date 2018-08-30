#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"
#import "headers/WAChatViewController.h"


%group GROUP_NO_READ_RECEIPT

	%hook XMPPConnection

		-(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1 {
			return;
		}

	%end

%end


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		-(void)layoutSubviews {

			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			
			// This will only run if it is not a group
			if([contactJID rangeOfString:@"-"].location == NSNotFound) {

				_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];

				CGFloat green = isOnline ? 1 : 0;
				CGFloat red = 1 - green;  // 0 if green is 1, 1 if green is 0

				UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
				imageView.layer.borderColor = [UIColor colorWithRed:red green:green blue:0 alpha:1.0].CGColor;
				imageView.layer.borderWidth = 2.0f;
			}
			return %orig;
		}

	%end

%end


%group GROUP_CONFIRM_CALL

	%hook WAChatViewController

		-(void)callButtonTapped:(id)arg1 {

			UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to call?" preferredStyle:UIAlertControllerStyleAlert];
	
			UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				return %orig;
			}];

			UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				return;
			}];
			
			[alert addAction:yesAction];
			[alert addAction:noAction];
			[self presentViewController:alert animated:YES completion:nil];
		}

    	-(void)videoCallButtonTapped:(id)arg1 {

			UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to call?" preferredStyle:UIAlertControllerStyleAlert];
	
			UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				return %orig;
			}];

			UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
				return;
			}];
			
			[alert addAction:yesAction];
			[alert addAction:noAction];
			[self presentViewController:alert animated:YES completion:nil];
		}

	%end

%end


#define prefGetBool(key) [[[NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/me.pr0crustes.betterw_prefs.plist"] valueForKey:key] boolValue]

%ctor {

	if (prefGetBool(@"pref_receipt")) {
		NSLog(@"[BetterW] -> Enabling: -No Read Receipt-");
		%init(GROUP_NO_READ_RECEIPT);
	} 

	if (prefGetBool(@"pref_online")) {
		NSLog(@"[BetterW] -> Enabling: -Who Is Online-");
		%init(GROUP_WHO_IS_ONLINE);
	}

	if (prefGetBool(@"pref_confirm_call")) {
		NSLog(@"[BetterW] -> Enabling: -Confirm Call-");
		%init(GROUP_CONFIRM_CALL);
	}

}

