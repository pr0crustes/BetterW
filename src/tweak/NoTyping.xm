#import "headers/WAChatManager.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_TYPING

	%hook WAChatManager

		-(void)changeOutgoingChatState:(unsigned long long)arg1 forJID:(id)arg2 {
			return %orig(0, arg2);
		}

		-(void)changeOutgoingChatState:(unsigned long long)arg1 forChatJID:(id)arg2 {
			return %orig(0, arg2);
		}

	%end

%end



%ctor {

	if (F_prefGetBool(@"pref_no_typing")) {
		F_logEnabling(@"No Typing");
		%init(GROUP_NO_TYPING);
	}

}
