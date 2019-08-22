@interface WAMessage : NSObject
    // The message text.
    @property(copy, nonatomic) NSString *text;
    // Returns if the message can be revoked (time limit).
    @property(readonly, nonatomic) _Bool canBeRevoked;
    // Holds the file path where the media (if any) is stored.
    @property(readonly, copy, nonatomic) NSString *mediaPath;
    // The date of the message
    @property(retain, nonatomic) NSDate *messageDate; // @dynamic messageDate;
    // If the sender is the user
    @property(nonatomic) _Bool isFromMe;
@end
