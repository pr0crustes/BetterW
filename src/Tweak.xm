#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"
#import "headers/WAChatViewController.h"
#import "headers/WAChatStorage.h"
#import "headers/WAMessage.h"
#import "Pr0_Macros.h"


%group GROUP_NO_READ_RECEIPT

	%hook XMPPConnection

		-(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1 {
			return;
		}

	%end

%end


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		%new
		-(void)pr0crustes_applyColorMask:(_Bool)isOnline {
			CGFloat green = isOnline ? 1 : 0;
			CGFloat red = 1 - green;  // 0 if green is 1, 1 if green is 0

			UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
			imageView.layer.borderColor = [UIColor colorWithRed:red green:green blue:0 alpha:1.0].CGColor;
			imageView.layer.borderWidth = 2.0f;
		}

		-(void)layoutSubviews {
			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			
			// This will only run if it is not a group
			if([contactJID rangeOfString:@"-"].location == NSNotFound) {
				_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];
				[self pr0crustes_applyColorMask:isOnline];
			}
			return %orig;
		}

	%end

%end


%group GROUP_CONFIRM_CALL

	%hook WAChatViewController

		-(void)callButtonTapped:(id)arg1 {
			MACRO_present_alert_with(%orig, return);
		}

    	-(void)videoCallButtonTapped:(id)arg1 {
			MACRO_present_alert_with(%orig, return);
		}

	%end

%end

%group NO_DELETE

	%hook WAChatStorage

		-(void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(NSString *)date {
			NSString* newText = [NSString stringWithFormat:@"#| Deleted Message |# \n\n %@", [message text]];
			[message setText:newText];
			return;
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

	if (prefGetBool(@"pref_no_delete")) {
		NSLog(@"[BetterW] -> Enabling: -No Delete-");
		%init(NO_DELETE);
	}

}

