#import "headers/WAMessage.h"
#import "headers/WAChatCellData.h"
#import "headers/WAMessageAudioSliceView.h"

#import "_Pr0_Utils.h"
#import "_opus_conversor.h"

#import <Speech/Speech.h>


NSString* GLOBAL_LOCALE = @"en_US";

bool GLOBAL_IS_PROCESSING = false;


%group GROUP_AUDIO_TO_TEXT

	%hook WAMessageAudioSliceView

	    %property (nonatomic, assign) BOOL pr0crustes_didConnectButton; // Make sure the button is only connected once.

		%new
		-(void)pr0crustes_doAudioToText {

			GLOBAL_IS_PROCESSING = true;

			WAChatCellData* data = MSHookIvar<WAChatCellData *>(self, "_lastCellData");
			NSString* fileIn = [[data message] mediaPath];
			NSString* outFile = [fileIn stringByAppendingString:@".wav"];

			__block UIActivityIndicatorView* activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
			[activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
			[activityIndicator setColor:[UIColor redColor]];

			UIView* topView = FUNCTION_getTopView();

			activityIndicator.center = topView.center;
			[topView addSubview:activityIndicator];

			[activityIndicator startAnimating];

			int result = pr0crustes_opusToWav([fileIn UTF8String], [outFile UTF8String]);

			if (result == PR0CRUSTES_OK) {
				NSLocale* local = [NSLocale localeWithLocaleIdentifier:GLOBAL_LOCALE];
				SFSpeechRecognizer* speechRecognizer = [[SFSpeechRecognizer alloc] initWithLocale:local];
				[speechRecognizer autorelease];

				NSURL* url = [NSURL fileURLWithPath:outFile];
				
				SFSpeechURLRecognitionRequest* urlRequest = [[SFSpeechURLRecognitionRequest alloc] initWithURL:url];
				[urlRequest autorelease];
				urlRequest.shouldReportPartialResults = true;  // Report only when done.
				
				__block UIAlertController* alert;

				[speechRecognizer recognitionTaskWithRequest:urlRequest resultHandler:
					^(SFSpeechRecognitionResult* result, NSError* error) {
						
						if (activityIndicator) {
							[activityIndicator stopAnimating];
							[activityIndicator release];
							activityIndicator = nil;
						}

						if (alert) {
							[alert dismissViewControllerAnimated:true completion:nil];
						}

						NSString *message = error ? [NSString stringWithFormat:@"Error processing text -> \n%@\nMay be your connection.", error] : result.bestTranscription.formattedString;
						
						FUNCTION_tryDeleteFile(outFile);

						GLOBAL_IS_PROCESSING = false;

						alert = [UIAlertController alertControllerWithTitle:@"AudioToText Result:\n" message:message preferredStyle:UIAlertControllerStyleAlert];

						UIAlertAction* closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
						[alert addAction:closeAction];

						FUNCTION_presentAlert(alert, true);
					}
				];
				
			} else {
				FUNCTION_tryDeleteFile(outFile);
				FUNCTION_simpleAlert(@"AudioToText Error:\n", [NSString stringWithFormat:@"Code: %i", result]);
				GLOBAL_IS_PROCESSING = false;
			}
		}

		%new
		-(void)pr0crustes_onButtonHold:(UILongPressGestureRecognizer *)recognizer {
			if (recognizer.state == UIGestureRecognizerStateBegan && !GLOBAL_IS_PROCESSING) {
				[self pr0crustes_doAudioToText];
			}
		}

		-(void)layoutSubviews {
			%orig;

			if (!self.pr0crustes_didConnectButton) {
				UIButton* button = MSHookIvar<UIButton *>(self, "_playPauseButton");
				UILongPressGestureRecognizer* buttonHold = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pr0crustes_onButtonHold:)];
				[button addGestureRecognizer:buttonHold];

				self.pr0crustes_didConnectButton = true;
			}
		}

	%end


	%hook NSBundle

		-(id)infoDictionary {
			NSMutableDictionary *dictionary = [%orig mutableCopy];
			dictionary[@"NSSpeechRecognitionUsageDescription"] = @"[BetterW] -> Needed for AudioToText.";
			return dictionary;
		}

	%end

%end



%ctor {

	if (FUNCTION_prefGetBool(@"pref_audio_to_text")) {
		FUNCTION_logEnabling(@"Audio To Text");
		GLOBAL_LOCALE = FUNCTION_prefGet(@"pref_audio_to_text_locale");
		%init(GROUP_AUDIO_TO_TEXT);
	}

}
