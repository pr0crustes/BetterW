#import "headers/UIDeviceWhatsapp.h"

#import "_Pr0_Utils.h"


%group GROUP_GLOBAL_SUPPORT

	%hook UIDevice

		-(_Bool)wa_isDeviceSupported {
			return true;
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_global_support")) {
		MACRO_log_enabling(@"Global Support");
		%init(GROUP_GLOBAL_SUPPORT);
	}

}
