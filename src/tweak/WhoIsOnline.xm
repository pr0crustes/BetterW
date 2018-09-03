#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"

#import "Pr0_Macros.h"


bool GLOBAL_as_dot = false;


void pr0crustes_drawBorder(UIImageView* imageView, UIColor* color) {
	imageView.layer.borderColor = color.CGColor;
	imageView.layer.borderWidth = 2.0f;
}


void pr0crustes_drawDot(UIImageView* imageView, UIColor* color) {
	UIGraphicsBeginImageContextWithOptions(imageView.image.size, NO, 0);

	[imageView.image drawAtPoint:CGPointZero];

	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, color.CGColor);

	CGContextBeginPath(context);
	CGContextAddEllipseInRect(context, CGRectMake(120, 120, 25, 25));
	CGContextDrawPath(context, kCGPathFill);

	imageView.image = UIGraphicsGetImageFromCurrentImageContext();

	UIGraphicsEndImageContext();
}


void pr0crustes_drawOnlineIndicator(UIImageView* imageView, _Bool isOnline) {
	UIColor* color = isOnline ? [UIColor greenColor] : [UIColor redColor];
	if (GLOBAL_as_dot) {
		pr0crustes_drawDot(imageView, color);
	} else {
		pr0crustes_drawBorder(imageView, color);
	}
}


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		%property (nonatomic, assign) BOOL pr0crustes_previousState;
		%property (nonatomic, assign) BOOL pr0crustes_alreadyRunned;

		-(void)layoutSubviews {
					
			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];

			if (!MACRO_is_contactJID_group(contactJID) && (isOnline != self.pr0crustes_previousState || !self.pr0crustes_alreadyRunned)) {
				UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
				pr0crustes_drawOnlineIndicator(imageView, isOnline);
				self.pr0crustes_previousState = isOnline;
				self.pr0crustes_alreadyRunned = true;
			}

			return %orig;
		}

	%end
	

	// %hook WAContactTableViewCell

	// 	%property (nonatomic, assign) BOOL pr0crustes_previousState;
	// 	%property (nonatomic, assign) BOOL pr0crustes_alreadyRunned;

	// 	-(void)layoutSubviews {

	// 		NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
	// 		_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];

	// 		if (!MACRO_is_contactJID_group(contactJID) && (isOnline != self.pr0crustes_previousState || !self.pr0crustes_alreadyRunned)) {
	// 			UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContact");				pr0crustes_drawOnlineIndicator(imageView, isOnline);
	// 			self.pr0crustes_previousState = isOnline;
	// 			self.pr0crustes_alreadyRunned = true;
	// 		}

	// 		return %orig;
	// 	}

	// %end

%end


%ctor {

	if (MACRO_pref_get_bool(@"pref_online")) {
		MACRO_log_enabling(@"Who Is Online");

		// if (MACRO_pref_get_bool(@"pref_as_dot")) {
		// 	MACRO_log_enabling(@"... As Dot");
		// 	GLOBAL_as_dot = true;
		// }

		%init(GROUP_WHO_IS_ONLINE);
	}

}
