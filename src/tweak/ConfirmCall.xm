#import "headers/WACallManager.h"

#import "_Pr0_Utils.h"


%group GROUP_CONFIRM_CALL

	%hook WACallManager

		-(void)internalAttemptOutgoingVoiceCallWithJID:(NSString*)contactJID callUISource:(int)arg2 withVideo:(_Bool)isVideo {

			NSString* alertMessage = isVideo ? @"Confirm Video Call?" : @"What Type Of Call?";
			UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:alertMessage preferredStyle:UIAlertControllerStyleAlert];

			NSString* yesMessage = isVideo ? @"Yes" : @"WhatsApp Call";
			UIAlertAction* yesAction = [UIAlertAction actionWithTitle:yesMessage style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
				%orig;
			}];
			[alert addAction:yesAction];
			
			if (!isVideo) { 
				UIAlertAction* phoneCallAction = [UIAlertAction actionWithTitle:@"Phone Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
					NSString *phoneNumber = [contactJID componentsSeparatedByString:@"@"][0];
					NSURL* url = [NSURL URLWithString:[@"telprompt://+" stringByAppendingString:phoneNumber]];
					[[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
				}];
				[alert addAction:phoneCallAction];
			} 

			UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
			[alert addAction:cancelAction];

			FUNCTION_presentAlert(alert, true);
		}

	%end
	
%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_confirm_call")) {
		MACRO_log_enabling(@"Confirm Call");
		%init(GROUP_CONFIRM_CALL);
	}

}
