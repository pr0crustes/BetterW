#import "headers/WAChatStorage.h"
#import "headers/WAMessage.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_DELETE

	%hook WAChatStorage

		- (void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(id)arg4 deferAction:(id)arg5 {
			[message setText:[NSString stringWithFormat:@"◉【 Deleted Message 】◉ \n\n %@", [message text]]];
			return;
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_no_delete")) {
		FUNCTION_logEnabling(@"No Delete");
		%init(GROUP_NO_DELETE);
	}

}

