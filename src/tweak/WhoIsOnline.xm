#import "headers/XMPPConnection.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WASharedAppData.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"

#import "_Pr0_Macros.h"

// A simple macro to find the correct color, based on a boolean isOnline,
#define MACRO_onlineColor(isOnline) (isOnline ? [UIColor greenColor] : [UIColor redColor]).CGColor


bool GLOBAL_as_dot = false;

// Function that creates a circular CAShapeLayer at desired pos.
CAShapeLayer* pr0crustes_createDotIndicator(UIView* view, CGFloat pos) {
	CAShapeLayer* circle = [CAShapeLayer layer];
	circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(pos, pos, 10, 10)].CGPath;
	[view.layer addSublayer:circle];
	return circle;
}

// Function that adds a border to an ImageView, coloring based in isOnline.
void pr0crustes_colorBorder(UIImageView* imageView, _Bool isOnline) {
	imageView.layer.borderColor = MACRO_onlineColor(isOnline);
	imageView.layer.borderWidth = 2.0f;
}

// Function that changes the color of a CAShapeLayer, based in isOnline.
void pr0crustes_colorDot(CAShapeLayer* circle, _Bool isOnline) {
	circle.fillColor = MACRO_onlineColor(isOnline);
}


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		%property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;

		-(void)layoutSubviews {
					
			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];

			if (!MACRO_is_contactJID_group(contactJID)) {
				UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
				
				if (GLOBAL_as_dot) {
					if (self.pr0crustes_circleLayer == nil) {
						self.pr0crustes_circleLayer = pr0crustes_createDotIndicator(imageView, 35);
					}
					pr0crustes_colorDot(self.pr0crustes_circleLayer, isOnline);
				} else {
					pr0crustes_colorBorder(imageView, isOnline);
				}
			}

			return %orig;
		}

	%end
	

	%hook WAContactTableViewCell

		%property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;

		-(void)layoutSubviews {

			NSString* contactJID = MSHookIvar<NSString *>(self, "_jid");
			_Bool isOnline = [[%c(WASharedAppData) xmppConnection] isOnline:contactJID];

			if (!MACRO_is_contactJID_group(contactJID)) {
				UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContact");  // Not the same ivar

				if (GLOBAL_as_dot) {
					if (self.pr0crustes_circleLayer == nil) {
						self.pr0crustes_circleLayer = pr0crustes_createDotIndicator(imageView, 25);
					}
					pr0crustes_colorDot(self.pr0crustes_circleLayer, isOnline);
				} else {
					pr0crustes_colorBorder(imageView, isOnline);
				}
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
