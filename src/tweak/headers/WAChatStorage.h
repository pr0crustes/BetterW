#import "headers/WAMessage.h"

@interface WAChatStorage : NSObject
@end


@interface WAChatStorage (Revoke)
	// Deletes a message from the ChatStorage.
	-(void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(id)arg4 deferAction:(id)arg5;
@end
