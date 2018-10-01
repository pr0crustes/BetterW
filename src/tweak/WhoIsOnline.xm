#import "headers/WAContextMain.h"
#import "headers/XMPPConnectionMain.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"

#import "_Pr0_Utils.h"

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


#define MACRO_Who_Is_Online(stringImageIvar, floatSize) \
{ \
	NSString* contactJID = MSHookIvar<NSString *>(self, "_jid"); \
	_Bool isOnline = [[[%c(WAContextMain) sharedContext] xmppConnectionMain] isOnline:contactJID]; \
	if (!FUNCTION_contactIsGroup(contactJID)) { \
		UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, stringImageIvar); \
		if (GLOBAL_as_dot) { \
			if (self.pr0crustes_circleLayer == nil) { \
				self.pr0crustes_circleLayer = pr0crustes_createDotIndicator(imageView, floatSize); \
			} \
			pr0crustes_colorDot(self.pr0crustes_circleLayer, isOnline); \
		} else { \
			pr0crustes_colorBorder(imageView, isOnline); \
		} \
	} \
}


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		%property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;

		-(void)layoutSubviews {
			MACRO_Who_Is_Online("_imageViewContactPicture", 35);
			return %orig;
		}

	%end
	

	%hook WAContactTableViewCell

		%property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;

		-(void)layoutSubviews {
			MACRO_Who_Is_Online("_imageViewContact", 25);
			return %orig;
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_online")) {
		FUNCTION_logEnabling(@"Who Is Online");

		if (FUNCTION_prefGetBool(@"pref_as_dot")) {
			FUNCTION_logEnabling(@"... As Dot");
			GLOBAL_as_dot = true;
		}

		%init(GROUP_WHO_IS_ONLINE);
	}

}
