#import "headers/WAContextMain.h"
#import "headers/XMPPConnectionMain.h"
#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"
#import "headers/WAUserJID.h"

#import "_Pr0_Utils.h"

// A simple macro to find the correct color, based on a boolean isOnline,
#define MACRO_onlineColor(isOnline) (isOnline ? [UIColor greenColor] : [UIColor redColor]).CGColor


bool GLOBAL_AS_DOT = false;

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
	NSString* stringJID = [self jid]; \
	if (!FUNCTION_JIDIsGroup(stringJID)) { \
		WAUserJID* jid = FUNCTION_userJIDFromString(stringJID); \
		XMPPConnectionMain* connection = [[%c(WAContextMain) sharedContext] xmppConnectionMain]; \
		[connection presenceSubscribeToJIDIfNecessary:jid]; \
		_Bool isOnline = [connection isOnline:jid]; \
		UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, stringImageIvar); \
		if (GLOBAL_AS_DOT) { \
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
			%orig;
			MACRO_Who_Is_Online("_imageViewContactPicture", 35);
		}

	%end
	

	%hook WAContactTableViewCell

		%property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;

		-(void)layoutSubviews {
			%orig;
			MACRO_Who_Is_Online("_imageViewContact", 25);
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_online")) {
		FUNCTION_logEnabling(@"Who Is Online");

		if (FUNCTION_prefGetBool(@"pref_as_dot")) {
			FUNCTION_logEnabling(@"... As Dot");
			GLOBAL_AS_DOT = true;
		}

		%init(GROUP_WHO_IS_ONLINE);
	}

}
