#import "headers/WAChatManager.h"

#import "_Pr0_Macros.h"


%group GROUP_NO_TYPING

	%hook WAChatManager

		-(void)changeOutgoingChatState:(unsigned long long)arg1 forJID:(id)arg2 {
			return %orig(0, arg2);
		}

	%end

%end



%ctor {

	if (MACRO_pref_get_bool(@"pref_no_typing")) {
		MACRO_log_enabling(@"No Typing");
		%init(GROUP_NO_TYPING);
	}

}
