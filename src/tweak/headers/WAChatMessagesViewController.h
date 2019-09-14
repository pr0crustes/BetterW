#import "WAChatMessagesController.h"
#import "WAMessage.h"

@interface WAChatMessagesViewController : UIViewController {
        WAChatMessagesController *_messagesController;
    }

    -(id)allSelectedMessages;
    -(void)deleteSelectedMessages:(id)arg1;
    -(void)doneEditing:(id)arg1;

    // New
    -(void)pr0crustes_subsequentDelete:(WAMessage *)message;
    -(NSMutableArray<WAMessage *>*)pr0crustes_messagesToDelete:(WAMessage *)firstMessage;
@end
