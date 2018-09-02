#import "headers/WAMessage.h"

@interface WAChatStorage : NSObject
	-(void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(NSString *)date;
@end
