#import "headers/XMPPPresenceStanza.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_ONLINE

	%hook XMPPPresenceStanza

		// Called when creating a PresenceStanza
		+(id)stanzaWithPresence:(unsigned long long)arg1 nickname:(id)arg2 {
			return %orig(3, arg2);
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_no_online") && !FUNCTION_prefGetBool(@"pref_no_delete")) {
		MACRO_log_enabling(@"No Online");
		%init(GROUP_NO_ONLINE);
	} 

}
