#import "headers/WAChatStorage.h"
#import "headers/WAMessage.h"

#import "_Pr0_Macros.h"


%group NO_DELETE

	%hook WAChatStorage

		// Called when someone revokes a message, replacing it with deleted. 
        // We append new text to the message, returning.
		-(void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(id)arg4 {
			NSString* newText = [NSString stringWithFormat:@"◉【 Deleted Message 】◉ \n\n %@", [message text]];
			[message setText:newText];
			return;
		}

	%end

%end



%ctor {

	if (MACRO_pref_get_bool(@"pref_no_delete")) {
		MACRO_log_enabling(@"No Delete");
		%init(NO_DELETE);
	}

}

