#import "WAJID.h"

@interface XMPPPresenceController : NSObject
    // Subscribes to jid.
    - (void)subscribeToJIDIfNecessary:(WAJID *)jid;
    // Returns if given jid is online.
    - (_Bool)isUserOnline:(WAJID *)jid;
@end
