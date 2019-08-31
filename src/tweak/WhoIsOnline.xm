#import "headers/WAChatSessionCell.h"
#import "headers/WAContactTableViewCell.h"
#import "headers/WAProfilePictureDynamicThumbnailView.h"
#import "headers/WAJID.h"

#import "_Pr0_Utils.h"


UIColor* color_from_pref(NSString* key) {
	NSString* value = FUNCTION_prefGet(key);

	if ([value isEqualToString:@"Black"]) {
		return [UIColor blackColor];
	}
	if ([value isEqualToString:@"Blue"]) {
		return [UIColor blueColor];
	}
	if ([value isEqualToString:@"Brown"]) {
		return [UIColor brownColor];
	}
	if ([value isEqualToString:@"Cyan"]) {
		return [UIColor cyanColor];
	}
	if ([value isEqualToString:@"DarkGray"]) {
		return [UIColor darkGrayColor];
	}
	if ([value isEqualToString:@"Gray"]) {
		return [UIColor grayColor];
	}
	if ([value isEqualToString:@"Green"]) {
		return [UIColor greenColor];
	}
	if ([value isEqualToString:@"LightGray"]) {
		return [UIColor lightGrayColor];
	}
	if ([value isEqualToString:@"Magenta"]) {
		return [UIColor magentaColor];
	}
	if ([value isEqualToString:@"Orange"]) {
		return [UIColor orangeColor];
	}
	if ([value isEqualToString:@"Purple"]) {
		return [UIColor purpleColor];
	}
	if ([value isEqualToString:@"Red"]) {
		return [UIColor redColor];
	}
	if ([value isEqualToString:@"White"]) {
		return [UIColor whiteColor];
	}
	if ([value isEqualToString:@"Yellow"]) {
		return [UIColor yellowColor];
	}
	return [UIColor clearColor];
}


bool GLOBAL_AS_DOT = false;
UIColor* GLOBAL_COLOR_ONLINE = color_from_pref(@"pref_woi_color_online");
UIColor* GLOBAL_COLOR_OFFLINE = color_from_pref(@"pref_woi_color_offline");


// Function that creates a circular CAShapeLayer at desired pos, the dot indicator.
CAShapeLayer* pr0crustes_createDotIndicator(UIView* view, CGFloat pos) {
	CAShapeLayer* circle = [CAShapeLayer layer];
	circle.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(pos, pos, 10, 10)].CGPath;
	[view.layer addSublayer:circle];
	return circle;
}


CGColor* pr0crustes_indicatorColor(WAJID* jid) {
	NSString* stringJID = [jid stringRepresentation];
	if (FUNCTION_JIDIsGroup(stringJID)) {
		return [UIColor clearColor].CGColor;
	}
	if (FUNCTION_isJidOnline(stringJID)) {
		return GLOBAL_COLOR_ONLINE.CGColor;
	}
	return GLOBAL_COLOR_OFFLINE.CGColor;
}


void pr0crustes_whoIsOnline(WAJID* jid, UIImageView* imageView, CAShapeLayer* layer, CGFloat size) {
	if (GLOBAL_AS_DOT) {
		if (layer == nil) {
			layer = pr0crustes_createDotIndicator(imageView, size);
		}
		layer.fillColor = pr0crustes_indicatorColor(jid);
	} else {
		imageView.layer.borderColor = pr0crustes_indicatorColor(jid);
		imageView.layer.borderWidth = 2.0f;
	}
}


%group GROUP_WHO_IS_ONLINE

	%hook WAChatSessionCell

		%property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;

		-(void)layoutSubviews {
			%orig;
			UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContactPicture");
			WAJID* jid = [[self chatSession] chatJID];
			pr0crustes_whoIsOnline(jid, imageView, self.pr0crustes_circleLayer, 35);
		}

	%end
	

	%hook WAContactTableViewCell

		%property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;

		-(void)layoutSubviews {
			%orig;
			UIImageView* imageView = MSHookIvar<WAProfilePictureDynamicThumbnailView *>(self, "_imageViewContact");
			WAJID* jid = [self profilePictureJID];
			pr0crustes_whoIsOnline(jid, imageView, self.pr0crustes_circleLayer, 25);
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
