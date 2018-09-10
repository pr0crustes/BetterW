#import "headers/WAMessage.h"

#import "_Pr0_Macros.h"


%group GROUP_NO_DELETE_LIMIT

    %hook WAMessage

        // Called to see if this message can be deleted
        -(_Bool)canBeRevoked {
            return true;
        }

    %end

%end



%ctor {

	if (MACRO_pref_get_bool(@"pref_no_delete_limit")) {
		MACRO_log_enabling(@"No Delete Limit");
		%init(GROUP_NO_DELETE_LIMIT);
	} 

}
