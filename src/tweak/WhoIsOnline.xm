#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"

#import "Pr0_Macros.h"


// Function that does the hard work, checking if is not a group 
// checking if the contact is online and setting the color.
void pr0crustes_applyOnlineMask(UIImageView* imageView, NSString* contactJID) {
	if([contactJID rangeOfString:@"-"].location == NSNotFound) {  // False if is a group
		_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];
		CGFloat green = isOnline ? 1 : 0;
		CGFloat red = 1 - green;  // 0 if green is 1, 1 if green is 0
		imageView.layer.borderColor = [UIColor colorWithRed:red green:green blue:0 alpha:1.0].CGColor;
		imageView.layer.borderWidth = 2.0f;
	}
}


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		-(void)layoutSubviews {
			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
			pr0crustes_applyOnlineMask(imageView, contactJID);
			return %orig;
		}

	%end


	%hook WAContactTableViewCell

		-(void)layoutSubviews {
			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContact");
			pr0crustes_applyOnlineMask(imageView, contactJID);
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
