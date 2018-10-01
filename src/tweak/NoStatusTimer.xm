#import "headers/WAStatusViewerViewController.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_STATUS_TIMER

    %hook WAStatusViewerViewController

        -(void)statusViewerSectionViewDidFinishPresentingItem:(id)arg1 {
            return;
        }

    %end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_no_status_timer")) {
		FUNCTION_logEnabling(@"No Status Timer");
		%init(GROUP_NO_STATUS_TIMER);
	}

}

