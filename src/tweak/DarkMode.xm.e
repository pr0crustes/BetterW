#import "_Pr0_Utils.h"


/* WARNING
* The things that start with ///def or ///use ARE NOT comments, but preprocess instructions.
* These instructions are used by PreProcessor.py to replace, basically being a macro that is runned before Logos.
* 
* Maybe it's too late for my soul.
*/


///def prep_class(a, b) -> @interface !a : !b @end
///def prep_classUIView(a) -> ///use prep_class(!a, UIView)
///def prep_hookUIView(a) -> %hook !a -(void)layoutSubviews { %orig; self.backgroundColor = [UIColor blackColor]; } %end
///def prep_setBackgroundColor() -> self.background = [UIColor blackColor];


///use prep_classUIView(_UINavigationBarContentView)
///use prep_classUIView(_UIStatusBarForegroundView)
///use prep_classUIView(_UINavigationBarLargeTitleView)
///use prep_classUIView(_WADraggableInputContainerView)
///use prep_classUIView(_WACustomBehaviorsTableView)
///use prep_classUIView(_UIBarBackground)
///use prep_classUIView(WATabBar)

///use prep_class(WABadgedLabel, UILabel)


%group GROUP_DARK_MODE

    ///use prep_hookUIView(_UINavigationBarContentView)
    ///use prep_hookUIView(_UIStatusBarForegroundView)
    ///use prep_hookUIView(_UINavigationBarLargeTitleView)
    ///use prep_hookUIView(_WADraggableInputContainerView)
    ///use prep_hookUIView(_WACustomBehaviorsTableView)
    ///use prep_hookUIView(_UIBarBackground)
    ///use prep_hookUIView(WATabBar)
    ///use prep_hookUIView(UITableViewCell)
    ///use prep_hookUIView(UITableView)
    ///use prep_hookUIView(UISearchBar)

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

%end


%ctor {
    if (FUNCTION_prefGetBool(@"pref_dark_mode")) {
        FUNCTION_logEnabling(@"Dark Mode");
        %init(GROUP_DARK_MODE);
    }
}
