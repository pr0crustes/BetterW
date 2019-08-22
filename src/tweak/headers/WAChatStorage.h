#import "WAMessage.h"

@interface WAChatStorage : NSObject
@end


@interface WAChatStorage (Revoke)
	// Deletes a received message.
	-(void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(NSDate *)date deferAction:(id)arg5;
	// Deletes a user sent message
	-(void)revokeOutgoingMessages:(NSArray<WAMessage *>*)messages;
@end
