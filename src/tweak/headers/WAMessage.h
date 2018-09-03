@interface WAMessage : NSObject
    @property(copy, nonatomic) NSString *text;
    @property(readonly, nonatomic) _Bool canBeRevoked;
@end
