#import "headers/WhatsAppAppDelegate.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_ONLINE

	%hook WhatsAppAppDelegate

		- (_Bool)isUserAvailable {
			return false;
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_no_online")) {
		FUNCTION_logEnabling(@"No Online");
		%init(GROUP_NO_ONLINE);
	} 

}
