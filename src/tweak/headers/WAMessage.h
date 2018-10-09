@interface WAMessage : NSObject
    // The message text.
    @property(copy, nonatomic) NSString *text;
    // Returns if the message can be revoked (time limit).
    @property(readonly, nonatomic) _Bool canBeRevoked;
    // Holds the file path where the media (if any) is stored.
    @property(readonly, copy, nonatomic) NSString *mediaPath;
@end
