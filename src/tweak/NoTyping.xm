#import "headers/WAChatManager.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_TYPING

	%hook WAChatManager

		-(void)changeOutgoingChatState:(unsigned long long)arg1 forJID:(id)arg2 {
			return %orig(0, arg2);
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_no_typing")) {
		FUNCTION_logEnabling(@"No Typing");
		%init(GROUP_NO_TYPING);
	}

}
