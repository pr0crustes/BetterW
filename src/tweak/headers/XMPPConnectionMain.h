@interface XMPPConnectionMain : NSObject
    // Check if should send readReceipts and then sends.
    -(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1;
    // Returns if given contactJID is online.
    -(_Bool)isOnline:(NSString *)contactJID;
@end
