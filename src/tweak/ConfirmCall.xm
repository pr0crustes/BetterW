#import "headers/WACallManager.h"

#import "_Pr0_Utils.h"


%group GROUP_CONFIRM_CALL

	%hook WACallManager

		-(void)internalAttemptOutgoingVoiceCallWithJIDs:(id)contactJIDs callUISource:(int)arg2 withVideo:(_Bool)isVideo groupJID:(id)arg4 {
			int size = [contactJIDs count];
			if (size > 0) {

				NSString* alertMessage = isVideo ? @"Confirm Video Call?" : @"What Type Of Call?";
				UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];

				NSString* yesMessage = isVideo ? @"Yes" : @"WhatsApp Call";
				UIAlertAction* yesAction = [UIAlertAction actionWithTitle:yesMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
					%orig;
				}];
				[alert addAction:yesAction];
				
				if (!isVideo && size == 1) { 
					UIAlertAction* phoneCallAction = [UIAlertAction actionWithTitle:@"Phone Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
						NSString *phoneNumber = [[contactJIDs[0] stringRepresentation] componentsSeparatedByString:@"@"][0];
						NSURL* url = [NSURL URLWithString:[@"telprompt://+" stringByAppendingString:phoneNumber]];
						[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
					}];
					[alert addAction:phoneCallAction];
				} 

				UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
				[alert addAction:cancelAction];

				F_presentAlert(alert, true);
			}
		}

	%end
	
%end



%ctor {

	if (F_prefGetBool(@"pref_confirm_call")) {
		F_logEnabling(@"Confirm Call");
		%init(GROUP_CONFIRM_CALL);
	}

}
