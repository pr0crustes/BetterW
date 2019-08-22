#import "headers/WAChatMessagesViewController.h"
#import "headers/WAMessage.h"
#import "headers/WAChatCellData.h"
#import "headers/WAChatStorage.h"
#import "headers/WAContext.h"

#import "_Pr0_Utils.h"


%group GROUP_DELETE_SUBSEQUENT

	%hook WAChatMessagesViewController

		-(void)deleteSelectedMessages:(id)arg1 {
			NSArray<WAMessage *>* selectedMessages = [self allSelectedMessages];
			int count = [selectedMessages count];

			if (count == 1) {
				UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Subsequent?" message:@"Delete only selected or all subsequent messages?" preferredStyle:UIAlertControllerStyleAlert];

				UIAlertAction* onlySelectedAction = [UIAlertAction actionWithTitle:@"Only Selected" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
					%orig;
				}];
				[alert addAction:onlySelectedAction];

				UIAlertAction* subsequentAction = [UIAlertAction actionWithTitle:@"Subsequent Too" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
					[self pr0crustes_subsequentDelete:selectedMessages[0]];
				}];
				[alert addAction:subsequentAction];

				UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
				[alert addAction:cancelAction];

				FUNCTION_presentAlert(alert, true);
			} else {
				%orig;
			}
		}

		%new
		-(void)pr0crustes_subsequentDelete:(WAMessage *)origMessage {
			NSMutableArray<WAMessage *>* messagesToDelete = [self pr0crustes_messagesToDelete:origMessage];

			UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Are You Sure?" message:[NSString stringWithFormat:@"This action will revoke %lu messages.", (unsigned long) [messagesToDelete count]] preferredStyle:UIAlertControllerStyleAlert];

			UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
				WAContext* context = [NSClassFromString(@"WAContext") sharedContext];
				WAChatStorage* chatStorage = [context chatStorage];
				[chatStorage revokeOutgoingMessages:messagesToDelete];
				[self doneEditing:nil];  // this arg seens to be useless, usually receives the button.
			}];
			[alert addAction:yesAction];

			UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
			[alert addAction:cancelAction];

			FUNCTION_presentAlert(alert, true);
		}

		%new
		-(NSMutableArray<WAMessage *>*)pr0crustes_messagesToDelete:(WAMessage *)firstMessage {
			NSDate* selectedDate = [firstMessage messageDate];
			NSMutableArray<WAMessage *>* messagesToDelete = [[NSMutableArray alloc] init];
			[messagesToDelete addObject:firstMessage];

			WAChatMessagesController* messagesController = MSHookIvar<WAChatMessagesController *>(self, "_messagesController");
			if (messagesController) {
				[messagesController enumerateChatCellDataUsingBlock:^(WAChatCellData* data) {
					if (data) {
						WAMessage* message = [data message];
						if (message && [message isFromMe]) {
							NSDate* date = [message messageDate];
							if ([date compare:selectedDate] == NSOrderedDescending) {
								[messagesToDelete addObject:message];
							}
						}
					}
				}];
			}
			return messagesToDelete;
		}
	%end
%end



%ctor {
	if (true/*FUNCTION_prefGetBool(@"pref_delete_subsequent")*/) {
		FUNCTION_logEnabling(@"Delete Subsequent");
		%init(GROUP_DELETE_SUBSEQUENT);
	}
}
