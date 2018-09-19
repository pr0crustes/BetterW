#import "WAContext.h"
#import "XMPPConnectionMain.h"

@interface WAContextMain : WAContext
    // Returns the shared xmmppConnectionMain.
    @property(readonly, nonatomic) XMPPConnectionMain *xmppConnectionMain;
@end
