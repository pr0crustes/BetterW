#import "headers/XMPPConnection.h"

#import "Pr0_Macros.h"


%group GROUP_NO_READ_RECEIPT

	%hook XMPPConnection

		// This method is what send read receipts to others, we just return.
		-(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1 {
			return;
		}

	%end

%end



%ctor {

	if (MACRO_pref_get_bool(@"pref_receipt")) {
		MACRO_log_enabling(@"No Read Receipt");
		%init(GROUP_NO_READ_RECEIPT);
	} 

}
