#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"

#import "Pr0_Macros.h"


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


%ctor {

	if (MACRO_pref_get_bool(@"pref_online")) {
		MACRO_log_enabling(@"Who Is Online");
		%init(GROUP_WHO_IS_ONLINE);
	}

}
