#import "headers/WAChatMessagesViewController.h"
#import "headers/WAContactViewController.h"

#import "_Pr0_Utils.h"


%group GROUP_CONFIRM_CALL

	%hook WAChatMessagesViewController

		// Called when the user clicks to call
		-(void)callContactWithJID:(id)arg1 withVideo:(_Bool)arg2 {
			MACRO_present_alert_with(self, %orig;, nil;);
		}

	%end

	%hook WAContactViewController

		// Called when the user clicks to call
		-(void)callContactWithJID:(id)arg1 withVideo:(_Bool)arg2 {
			MACRO_present_alert_with(self, %orig;, nil;);
		}

	%end
	
%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_confirm_call")) {
		MACRO_log_enabling(@"Confirm Call");
		%init(GROUP_CONFIRM_CALL);
	}

}
