#import "headers/XMPPPresenceStanza.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_ONLINE

	%hook XMPPPresenceStanza

		+(id)stanzaWithPresence:(unsigned long long)arg1 nickname:(id)arg2 {
			return %orig(3, arg2);
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_no_online")) {
		FUNCTION_logEnabling(@"No Online");
		%init(GROUP_NO_ONLINE);
	} 

}
