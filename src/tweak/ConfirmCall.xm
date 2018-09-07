#import "headers/WAChatMessagesViewController.h"
#import "headers/WAContactViewController.h"

#import "_Pr0_Macros.h"


%group GROUP_CONFIRM_CALL

	%hook WAChatMessagesViewController

		-(void)callContactWithJID:(id)arg1 withVideo:(_Bool)arg2 {
			MACRO_present_alert_with(self, %orig;, nil;);
		}

	%end

	%hook WAContactViewController

		-(void)callContactWithJID:(id)arg1 withVideo:(_Bool)arg2 {
			MACRO_present_alert_with(self, %orig;, nil;);
		}

	%end
	
%end



%ctor {

	if (MACRO_pref_get_bool(@"pref_confirm_call")) {
		MACRO_log_enabling(@"Confirm Call");
		%init(GROUP_CONFIRM_CALL);
	}

}
