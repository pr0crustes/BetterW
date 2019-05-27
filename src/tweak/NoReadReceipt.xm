#import "headers/XMPPConnectionMain.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_READ_RECEIPT

	%hook XMPPConnectionMain

		-(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1 {
			return;
		}

		-(void)sendPlayedReceiptForMessage:(id)arg1 {
			return;
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_receipt")) {
		FUNCTION_logEnabling(@"No Read Receipt");
		%init(GROUP_NO_READ_RECEIPT);
	} 

}
