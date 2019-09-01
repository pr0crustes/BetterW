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

	if (F_prefGetBool(@"pref_global_support")) {
		F_logEnabling(@"Global Support");
		%init(GROUP_GLOBAL_SUPPORT);
	}

}
