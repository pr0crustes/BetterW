#import "headers/XMPPPresenceStanza.h"

#import "Pr0_Macros.h"


%group GROUP_NO_ONLINE

	%hook XMPPPresenceStanza

		+(id)stanzaWithPresence:(unsigned long long)arg1 nickname:(id)arg2 {
			return %orig(3, arg2);
		}

	%end

%end



%ctor {

	if (MACRO_pref_get_bool(@"pref_no_online")) {
		MACRO_log_enabling(@"No Online");
		%init(GROUP_NO_ONLINE);
	} 

}
