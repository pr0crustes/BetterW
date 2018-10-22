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


%hook UILabel
-(void)setBackgroundColor:(id)arg1 { 
    return %orig([UIColor clearColor]); 
} 
-(id)backgroundColor { 
    return [UIColor clearColor]; 
}
    -(void)setTextColor:(id)arg1 {
        return %orig([UIColor whiteColor]);
    }
    -(id)textColor {
        return [UIColor whiteColor];
    }
%end



%ctor {
    if (FUNCTION_prefGetBool(@"pref_dark_mode")) {
        FUNCTION_logEnabling(@"Dark Mode");
        %init(_ungrouped);
    }
}
