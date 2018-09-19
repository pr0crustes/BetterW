#import "headers/WAChatMessagesViewController.h"
#import "headers/WAContactViewController.h"

#import "_Pr0_Utils.h"


#define MACRO_Confirm_Call(origHandler) \
{ \
	NSString* message = arg2 ? @"Confirm Video Call?" : @"What Type Of Call?"; \
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:message preferredStyle:UIAlertControllerStyleAlert]; \
	if (arg2) { \
		UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { origHandler; }]; \
		[alert addAction:yesAction]; \
	} else { \
		UIAlertAction* wcallAction = [UIAlertAction actionWithTitle:@"Whatsapp Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { origHandler; }]; \
		[alert addAction:wcallAction]; \
		UIAlertAction* phoneCallAction = [UIAlertAction actionWithTitle:@"Phone Call" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { \
			NSString *phoneNumber = [contactJID componentsSeparatedByString:@"@"][0]; \
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"telprompt://+" stringByAppendingString:phoneNumber]] options:@{} completionHandler:nil]; \
		}]; \
		[alert addAction:phoneCallAction]; \
	} \
	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]; \
	[alert addAction:cancelAction]; \
	[self presentViewController:alert animated:YES completion:nil]; \
}


%group GROUP_CONFIRM_CALL

	%hook WAChatMessagesViewController

		-(void)callContactWithJID:(NSString*)contactJID withVideo:(_Bool)arg2 {
			MACRO_Confirm_Call(%orig);
		}

	%end

	%hook WAContactViewController

		-(void)callContactWithJID:(NSString*)contactJID withVideo:(_Bool)arg2 {
			MACRO_Confirm_Call(%orig);
		}

	%end
	
%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_confirm_call")) {
		MACRO_log_enabling(@"Confirm Call");
		%init(GROUP_CONFIRM_CALL);
	}

}
