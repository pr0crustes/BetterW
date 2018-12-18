#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"

#import "_Pr0_Utils.h"


bool GLOBAL_AS_DOT = false;


// Function that creates a circular CAShapeLayer at desired pos.
CAShapeLayer* pr0crustes_createDotIndicator(UIView* view, CGFloat pos) {
	CAShapeLayer* circle = [CAShapeLayer layer];
	circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(pos, pos, 10, 10)].CGPath;
	[view.layer addSublayer:circle];
	return circle;
}


CGColor* pr0crustes_indicatorColor(NSString* jid) {
	if (FUNCTION_JIDIsGroup(jid)) {
		return [UIColor clearColor].CGColor;
	}
	if (FUNCTION_isJidOnline(jid)) {
		return [UIColor greenColor].CGColor;
	}
	return [UIColor redColor].CGColor;
}


#define MACRO_Who_Is_Online(stringImageIvar, floatSize) \
{ \
	NSString* stringJID = [self jid]; \
	UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, stringImageIvar); \
	if (GLOBAL_AS_DOT) { \
		if (self.pr0crustes_circleLayer == nil) { \
			self.pr0crustes_circleLayer = pr0crustes_createDotIndicator(imageView, floatSize); \
		} \
		self.pr0crustes_circleLayer.fillColor = pr0crustes_indicatorColor(stringJID); \
	} else { \
		imageView.layer.borderColor = pr0crustes_indicatorColor(stringJID); \
		imageView.layer.borderWidth = 2.0f; \
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
