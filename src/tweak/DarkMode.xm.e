#import "_Pr0_Utils.h"


/* WARNING
* The things that start with $def or $use ARE NOT comments, but preprocess instructions.
* These instructions are used by PreProcessor.py to replace, basically being a macro that is runned before Logos.
* 
* Maybe it's too late for my soul.
*/


$def pp_class(a, b) -> @interface !a : !b @end
$def pp_classView(a) -> $use pp_class(!a, UIView)
$def pp_openHook(a) -> %hook !a -(void)layoutSubviews { %orig; 
$def pp_closeHook() -> } %end
$def pp_hookViewColor(a, b) -> %hook !a -(void)layoutSubviews { %orig; self.backgroundColor = [UIColor !b]; } %end
$def pp_hookView(a) -> $use pp_hookViewColor(!a, blackColor)


$use pp_classView(_UINavigationBarContentView)
$use pp_hookView(_UINavigationBarContentView)

$use pp_classView(_UIStatusBarForegroundView)
$use pp_hookView(_UIStatusBarForegroundView)

$use pp_classView(_UINavigationBarLargeTitleView)
$use pp_hookView(_UINavigationBarLargeTitleView)

$use pp_classView(_UIBarBackground)
$use pp_hookView(_UIBarBackground)

$use pp_classView(_WADraggableInputContainerView)
$use pp_hookView(_WADraggableInputContainerView)

$use pp_classView(_WACustomBehaviorsTableView)
$use pp_hookView(_WACustomBehaviorsTableView)

$use pp_classView(WATabBar)
$use pp_hookView(WATabBar)

$use pp_classView(_WADividerCellBackground)
$use pp_hookViewColor(_WADividerCellBackground, grayColor)

$use pp_classView(WAMessageBubbleForwardButton)
$use pp_hookView(WAMessageBubbleForwardButton)

$use pp_hookView(UITableViewCell)

$use pp_hookView(UITableView)

$use pp_hookView(UISearchBar)

$use pp_class(WABadgedLabel, UILabel)
$use pp_openHook(WABadgedLabel)
    self.backgroundColor = [UIColor clearColor];
$use pp_closeHook()

$use pp_openHook(UILabel)
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
$use pp_closeHook()



%ctor {
    if (FUNCTION_prefGetBool(@"pref_dark_mode")) {
        FUNCTION_logEnabling(@"Dark Mode");
        %init(_ungrouped);
    }
}
