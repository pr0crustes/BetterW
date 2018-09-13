#import "headers/XMPPConnection.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_READ_RECEIPT

	%hook XMPPConnection

		// This method is what send read receipts to others, we just return.
		-(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1 {
			return;
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_receipt")) {
		MACRO_log_enabling(@"No Read Receipt");
		%init(GROUP_NO_READ_RECEIPT);
	} 

}
