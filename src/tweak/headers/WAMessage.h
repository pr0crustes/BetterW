@interface WAMessage : NSObject
    @property(copy, nonatomic) NSString *text;  // The message text.
    @property(readonly, nonatomic) _Bool canBeRevoked;  // Returns if the message can be revoked (time limit).
    @property(readonly, copy, nonatomic) NSString *mediaPath;
@end
