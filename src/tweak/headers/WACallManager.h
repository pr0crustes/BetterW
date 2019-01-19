@interface WACallManager : NSObject
    // Starts a call (voice or video).
    -(void)internalAttemptOutgoingVoiceCallWithJIDs:(id)contactJIDs callUISource:(int)arg2 withVideo:(_Bool)isVideo;
@end
