#import "_Pr0_Utils.h"


/* WARNING
* The things that start with $def or $use ARE NOT comments, but preprocess instructions.
* These instructions are used by PreProcessor.py to replace, basically being a macro that is runned before Logos.
* 
* Maybe it's too late for my soul.
*/










@interface _UIBarBackground : UIView 
@end
%hook _UIBarBackground 
-(void)setBackgroundColor:(id)arg1 { 
    return %orig([UIColor colorWithWhite:0.10 alpha:1.0]); 
} 
-(id)backgroundColor { 
    return [UIColor colorWithWhite:0.10 alpha:1.0]; 
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

%hook UISearchBar 
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
%hook UITableViewCell 
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
    -(void)layoutSubviews {
        %orig;
        if (self.subviews.count > 0) {
            [self.subviews[0] setTextColor:[UIColor whiteColor]];
        }
    }
%end


@interface WAContactNameLabel
- (void)setColor:(id)arg1;
@end

%hook WAContactNameLabel
- (void)setColor:(id)arg1 {
    return %orig([UIColor whiteColor]);
}
%end




@interface UILabel (pr0crustes)
    // these 2 methods are from https://gist.github.com/snikch/3661188 .
    - (UIViewController *)pr0crustes_topViewController;
    - (UIViewController *)pr0crustes_topViewController:(UIViewController *)rootViewController;

    -(bool)pr0crustes_isInAlert;
@end


%hook UILabel
-(void)setBackgroundColor:(id)arg1 { 
    return %orig([UIColor clearColor]); 
} 
-(id)backgroundColor { 
    return [UIColor clearColor]; 
}

    %new   // This method is from https://gist.github.com/snikch/3661188 .
    - (UIViewController *)pr0crustes_topViewController{
            return [self pr0crustes_topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    }

    %new   // This method is from https://gist.github.com/snikch/3661188 .
    - (UIViewController *)pr0crustes_topViewController:(UIViewController *)rootViewController {
        if (rootViewController.presentedViewController == nil) {
            return rootViewController;
        }
        
        if ([rootViewController.presentedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *) rootViewController.presentedViewController;
            UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
            return [self pr0crustes_topViewController:lastViewController];
        }
        
        UIViewController *presentedViewController = (UIViewController *) rootViewController.presentedViewController;
        return [self pr0crustes_topViewController:presentedViewController];
    }

    %new
    -(bool)pr0crustes_isInAlert {
        return [[self pr0crustes_topViewController] isKindOfClass:[UIAlertController class]];
    }

    -(void)setTextColor:(id)arg1 {
        if ([self pr0crustes_isInAlert]) {
            return %orig;
        }
        return %orig([UIColor whiteColor]);
    }
    -(id)textColor {
        if ([self pr0crustes_isInAlert]) {
            return %orig;
        }
        return [UIColor whiteColor];
    }
%end


%hook UINavigationController
    -(void)viewDidLoad {
        %orig;
        NSDictionary *attributes = @{
            NSForegroundColorAttributeName: [UIColor whiteColor]
        };
        [self.navigationBar setTitleTextAttributes:attributes];
    }
%end



%ctor {
    if (F_prefGetBool(@"pref_dark_mode")) {
        F_logEnabling(@"Dark Mode");
        %init(_ungrouped);
    }
}
