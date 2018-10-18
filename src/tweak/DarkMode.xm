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
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface _UIStatusBarForegroundView : UIView 
@end

%hook _UIStatusBarForegroundView 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface _UINavigationBarLargeTitleView : UIView 
@end

%hook _UINavigationBarLargeTitleView 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface _UIBarBackground : UIView 
@end

%hook _UIBarBackground 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface _WADraggableInputContainerView : UIView 
@end

%hook _WADraggableInputContainerView 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface _WACustomBehaviorsTableView : UIView 
@end

%hook _WACustomBehaviorsTableView 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface WATabBar : UIView 
@end

%hook WATabBar 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface _WADividerCellBackground : UIView 
@end

%hook _WADividerCellBackground 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor grayColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor grayColor]; 
    } 
%end

@interface WAMessageBubbleForwardButton : UIView 
@end

%hook WAMessageBubbleForwardButton 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

%hook UITableViewCell 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

%hook UITableView 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

%hook UISearchBar 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor blackColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor blackColor]; 
    } 
%end

@interface WABadgedLabel : UIView 
@end

%hook WABadgedLabel 
    -(void)setBackgroundColor:(id)arg1 { 
        return %orig([UIColor clearColor]); 
    } 
    -(id)backgroundColor { 
        return [UIColor clearColor]; 
    } 
%end
// $use pp_class(WABadgedLabel, UILabel)
// $use pp_openHook(WABadgedLabel)
//         self.backgroundColor = [UIColor clearColor];
// $use pp_closeHook()

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
