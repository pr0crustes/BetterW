@interface XMPPConnection : NSObject
    -(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1;
    -(_Bool)isOnline:(NSString *)contactJID;
@end
