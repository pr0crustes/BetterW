#import "_Pr0_Utils.h"


/* WARNING
* The things that start with $def or $use ARE NOT comments, but preprocess instructions.
* These instructions are used by PreProcessor.py to replace, basically being a macro that is runned before Logos.
* 
* Maybe it's too late for my soul.
*/


$def prep_class(a, b) -> @interface !a : !b @end
$def prep_classView(a) -> $use prep_class(!a, UIView)
$def prep_hookView(a) -> %hook !a -(void)layoutSubviews { %orig; self.backgroundColor = [UIColor blackColor]; } %end

$use prep_classView(_UINavigationBarContentView)
$use prep_classView(_UIStatusBarForegroundView)
$use prep_classView(_UINavigationBarLargeTitleView)
$use prep_classView(_WADraggableInputContainerView)
$use prep_classView(_WACustomBehaviorsTableView)
$use prep_classView(_UIBarBackground)
$use prep_classView(WATabBar)

$use prep_class(WABadgedLabel, UILabel)


@interface WAWallpaperView : UIView {
    UIImageView *_imageView;
}
@end


%group GROUP_DARK_MODE

    $use prep_hookView(_UINavigationBarContentView)
    $use prep_hookView(_UIStatusBarForegroundView)
    $use prep_hookView(_UINavigationBarLargeTitleView)
    $use prep_hookView(_WADraggableInputContainerView)
    $use prep_hookView(_WACustomBehaviorsTableView)
    $use prep_hookView(_UIBarBackground)
    $use prep_hookView(WATabBar)
    $use prep_hookView(UITableViewCell)
    $use prep_hookView(UITableView)
    $use prep_hookView(UISearchBar)

    %hook UILabel

        -(void)layoutSubviews {
            %orig;
            self.textColor = [UIColor whiteColor];
            self.backgroundColor = [UIColor clearColor];
        }

    %end

    %hook WABadgedLabel

        -(void)layoutSubviews {
            %orig;
            self.backgroundColor = [UIColor clearColor];
        }

    %end

    %hook WAWallpaperView

        -(void)layoutSubviews {
            %orig;
            MSHookIvar<UIImageView *>(self, "_imageView").hidden = true;
            self.backgroundColor = [UIColor blackColor];
        }

    %end

%end


%ctor {
    if (FUNCTION_prefGetBool(@"pref_dark_mode")) {
        FUNCTION_logEnabling(@"Dark Mode");
        %init(GROUP_DARK_MODE);
    }
}
