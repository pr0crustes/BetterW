#import "headers/WAChatManager.h"

#import "_Pr0_Macros.h"


%group GROUP_NO_TYPING

	%hook WAChatManager



	%end

%end



%ctor {

	if (MACRO_pref_get_bool(@"pref_no_typing")) {
		MACRO_log_enabling(@"No Typing");
		%init(GROUP_NO_TYPING);
	}

}
