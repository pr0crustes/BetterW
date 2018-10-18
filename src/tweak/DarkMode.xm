#import "_Pr0_Utils.h"
/* WARNING
* The things that start with $def or $use ARE NOT comments, but preprocess instructions.
* These instructions are used by PreProcessor.py to replace, basically being a macro that is runned before Logos.
* 
* Maybe it's too late for my soul.
*/

@interface _UINavigationBarContentView : UIView 
@end

%hook _UINavigationBarContentView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface _UIStatusBarForegroundView : UIView 
@end

%hook _UIStatusBarForegroundView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface _UINavigationBarLargeTitleView : UIView 
@end

%hook _UINavigationBarLargeTitleView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface _UIBarBackground : UIView 
@end

%hook _UIBarBackground 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface _WADraggableInputContainerView : UIView 
@end

%hook _WADraggableInputContainerView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface _WACustomBehaviorsTableView : UIView 
@end

%hook _WACustomBehaviorsTableView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface WATabBar : UIView 
@end

%hook WATabBar 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface _WADividerCellBackground : UIView 
@end

%hook _WADividerCellBackground 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor grayColor]; 
    } 
%end

@interface WAMessageBubbleForwardButton : UIView 
@end

%hook WAMessageBubbleForwardButton 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

%hook UITableViewCell 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

%hook UITableView 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

%hook UISearchBar 
    -(void)layoutSubviews { 
        %orig; 
        self.backgroundColor = [UIColor blackColor]; 
    } 
%end

@interface WABadgedLabel : UILabel 
@end

%hook WABadgedLabel 
    -(void)layoutSubviews { 
        %orig;
        self.backgroundColor = [UIColor clearColor];

    } 
%end

%hook UILabel 
    -(void)layoutSubviews { 
        %orig;
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor clearColor];

    } 
%end
%ctor {
    if (FUNCTION_prefGetBool(@"pref_dark_mode")) {
        FUNCTION_logEnabling(@"Dark Mode");
        %init(_ungrouped);
    }
}
