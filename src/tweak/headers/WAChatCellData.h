#import "WAMessage.h"

@interface WAChatCellData : NSObject
    @property(readonly, nonatomic) WAMessage *message;
    -(void)selectAllMessages;
@end
