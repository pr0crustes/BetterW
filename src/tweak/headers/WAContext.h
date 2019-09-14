#import "WAChatStorage.h"

@interface WAContext : NSObject
    // Returns a singleton.
    +(id)sharedContext;
    // The WAChatStorage singleton.
    @property(readonly, nonatomic) WAChatStorage *chatStorage;
@end
