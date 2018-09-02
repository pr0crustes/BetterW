#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"
#import "headers/WAChatStorage.h"
#import "headers/WAMessage.h"
#import "headers/UIDeviceWhatsapp.h"
#import "headers/WAChatMessagesViewController.h"
#import "headers/WAContactViewController.h"

#import "Pr0_Macros.h"


// Feature "No Read Receipt"
%group GROUP_NO_READ_RECEIPT

	%hook XMPPConnection

		// This method is what send read receipts to others, we just return.
		-(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1 {
			return;
		}

	%end

%end


// Feature "Who Is Online"
%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		// Adding a new method, that will apply the border with color to the profile image.
		%new
		-(void)pr0crustes_applyColorMask:(_Bool)isOnline {
			CGFloat green = isOnline ? 1 : 0;
			CGFloat red = 1 - green;  // 0 if green is 1, 1 if green is 0

			UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
			imageView.layer.borderColor = [UIColor colorWithRed:red green:green blue:0 alpha:1.0].CGColor;
			imageView.layer.borderWidth = 2.0f;
		}

		// Check if the user is online or not inside layoutSubviews, maybe there is a better place?
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


// Feature "Confirm Call"
%group GROUP_CONFIRM_CALL

	%hook WAChatMessagesViewController

		-(void)callContactWithJID:(id)arg1 withVideo:(_Bool)arg2 {
			MACRO_present_alert_with(self, %orig;, nil;);
		}

	%end

	%hook WAContactViewController

		-(void)callContactWithJID:(id)arg1 withVideo:(_Bool)arg2 {
			MACRO_present_alert_with(self, %orig;, nil;);
		}

	%end
	
%end


// Feature "No Delete"
%group NO_DELETE

	%hook WAChatStorage

		// Called when someone revokes a message, replacing it with deleted. We append new text to the message, returning.
		-(void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(id)arg4 {
			NSString* newText = [NSString stringWithFormat:@"#| Deleted Message |# \n\n %@", [message text]];
			[message setText:newText];
			return;
		}

	%end

%end


// Global Support (Adds whatsapp support to ipad, ipod)
%group GLOBAL_SUPPORT

	%hook UIDevice

		// Called to see if whatsapp shoud run on device.
		-(_Bool)wa_isDeviceSupported {
			return true;
		}

	%end

%end


// Constructor to enable desired features.
%ctor {

	// Global Support should be enabled first.
	if (MACRO_pref_get_bool(@"pref_global_support")) {
		MACRO_log_enabling(@"Global Support");
		%init(GLOBAL_SUPPORT);
	}

	if (MACRO_pref_get_bool(@"pref_receipt")) {
		MACRO_log_enabling(@"No Read Receipt");
		%init(GROUP_NO_READ_RECEIPT);
	} 

	if (MACRO_pref_get_bool(@"pref_online")) {
		MACRO_log_enabling(@"Who Is Online");
		%init(GROUP_WHO_IS_ONLINE);
	}

	if (MACRO_pref_get_bool(@"pref_confirm_call")) {
		MACRO_log_enabling(@"Confirm Call");
		%init(GROUP_CONFIRM_CALL);
	}

	if (MACRO_pref_get_bool(@"pref_no_delete")) {
		MACRO_log_enabling(@"No Delete");
		%init(NO_DELETE);
	}

}

