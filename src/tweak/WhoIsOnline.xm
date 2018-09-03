#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"

#import "Pr0_Macros.h"


bool GLOBAL_as_dot = false;

void pr0crustes_applyOnlineBorder(UIImageView* imageView, NSString* contactJID) {
	if(!MACRO_is_contactJID_group(contactJID)) {
		_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];
		imageView.layer.borderColor = (isOnline ? [UIColor greenColor] : [UIColor redColor]).CGColor;
		imageView.layer.borderWidth = 2.0f;
	}
}


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		-(void)layoutSubviews {
			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			if (GLOBAL_as_dot) {

			} else {
				UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
				pr0crustes_applyOnlineBorder(imageView, contactJID);
			}
			return %orig;
		}

	%end


	%hook WAContactTableViewCell

		-(void)layoutSubviews {
			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			if (GLOBAL_as_dot) {

			} else {
				UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContact");
				pr0crustes_applyOnlineBorder(imageView, contactJID);
			}
			return %orig;
		}

	%end

%end


%ctor {

	if (MACRO_pref_get_bool(@"pref_online")) {
		MACRO_log_enabling(@"Who Is Online");

		if (MACRO_pref_get_bool(@"pref_as_dot")) {
			MACRO_log_enabling(@"... As Dot");
			GLOBAL_as_dot = true;
		}

		%init(GROUP_WHO_IS_ONLINE);
	}

}
