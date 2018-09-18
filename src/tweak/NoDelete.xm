#import "headers/WAChatStorage.h"
#import "headers/WAMessage.h"

#import "_Pr0_Utils.h"


@interface WAChatStorage (Revoke)
- (void)revokeIncomingMessage:(id)arg1 updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(id)arg4 deferAction:(id)arg5;
- (void)internalRevokeOutgoingMessages:(id)arg1 fromWebClient:(_Bool)arg2 commonRevokeStanzaID:(id)arg3;
- (void)revokeOutgoingMessage:(id)arg1 fromWebClient:(_Bool)arg2 updatedStanzaID:(id)arg3;
- (void)revokeOutgoingMessages:(id)arg1;
- (void)internalRevokeMessages:(id)arg1 fromWebClient:(_Bool)arg2 commonUpdatedStanzaID:(id)arg3 beginTransactions:(id)arg4 commitTransactions:(id)arg5;
@end


%group GROUP_NO_DELETE

	%hook WAChatStorage

		- (void)revokeIncomingMessage:(id)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(id)arg4 deferAction:(id)arg5 {
			NSString* newText = [NSString stringWithFormat:@"◉【 Deleted Message 】◉ \n\n %@", [message text]];
			[message setText:newText];
			return;
		}

		// Called when someone revokes a message, replacing it with deleted. 
        // We append new text to the message, returning.
		// -(void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(id)arg4 {
		// 	PLog(@"WAChatStorage revokeIncomingMessage # old #");
		// 	NSString* newText = [NSString stringWithFormat:@"◉【 Deleted Message 】◉ \n\n %@", [message text]];
		// 	[message setText:newText];
		// 	return;
		// }

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_no_delete")) {
		MACRO_log_enabling(@"No Delete");
		%init(GROUP_NO_DELETE);
	}

}

