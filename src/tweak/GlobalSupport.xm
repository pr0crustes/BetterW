#import "headers/UIDeviceWhatsapp.h"

#import "_Pr0_Utils.h"


%group GROUP_GLOBAL_SUPPORT

	%hook UIDevice

		// Called to see if whatsapp shoud run on device.
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
