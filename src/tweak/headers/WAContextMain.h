#import "WAContext.h"
#import "XMPPConnectionMain.h"

@interface WAContextMain : WAContext
    @property(readonly, nonatomic) XMPPConnectionMain *xmppConnectionMain;
@end
