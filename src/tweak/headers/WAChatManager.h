@interface WAChatManager : NSObject
    // Changes the outgoing chat state, marking it as 'typing' and so on.
    -(void)changeOutgoingChatState:(unsigned long long)arg1 forJID:(id)arg2;
    -(void)changeOutgoingChatState:(unsigned long long)arg1 forChatJID:(id)arg2;
@end
