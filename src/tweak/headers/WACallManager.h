@interface WACallManager : NSObject
    // Starts a call (voice or video).
    -(void)internalAttemptOutgoingVoiceCallWithJIDs:(id)arg1 callUISource:(int)arg2 withVideo:(_Bool)arg3 groupJID:(id)arg4;
@end
