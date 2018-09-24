@interface WACallManager : NSObject
    // Starts a call (voice or video).
    -(void)internalAttemptOutgoingVoiceCallWithJID:(NSString*)contactJID callUISource:(int)arg2 withVideo:(_Bool)isVideo;
@end
