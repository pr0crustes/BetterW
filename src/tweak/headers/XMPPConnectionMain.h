#import "WAJID.h"
#import "XMPPPresenceController.h"

@interface XMPPConnectionMain : NSObject
    // Check if should send readReceipts and then sends.
    -(void)sendReadReceiptsForMessagesIfNeeded:(id)arg1;
    // Send readReceipts for audio messages.
    -(void)sendPlayedReceiptForMessage:(id)arg1;
    // The precense controller.
    @property(readonly, nonatomic) XMPPPresenceController *presenceController;
@end
