#import "headers/WAMessage.h"
#import "headers/WAChatCellData.h"
#import "headers/WAMessageAudioSliceView.h"

#import "_Pr0_Utils.h"
#import "_opus_conversor.h"

#import <Speech/Speech.h>


NSString* GLOBAL_LOCALE = @"en_US";

bool GLOBAL_IS_PROCESSING = false;



@interface Pr0crustes_Transcriber : NSObject
	+(id)createInstance;
	-(void)transcribeFile:(NSString *)filePath;
	-(void)transcriberCallback:(NSString *)message;

	@property (strong, nonatomic) UIAlertController* alert;
@end


@implementation Pr0crustes_Transcriber

	+(id)createInstance {
		id instance = [Pr0crustes_Transcriber alloc];
		[instance autorelease];
		return instance;
	}

	-(void)transcribeFile:(NSString*)fileIn {
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

			[speechRecognizer recognitionTaskWithRequest:urlRequest resultHandler:
				^(SFSpeechRecognitionResult* result, NSError* error) {

					if (activityIndicator) {
						[activityIndicator stopAnimating];
						[activityIndicator release];
						activityIndicator = nil;
					}

					GLOBAL_IS_PROCESSING = false;

					FUNCTION_tryDeleteFile(outFile);

					NSString *message = error ? [NSString stringWithFormat:@"Error processing text -> \n%@\nMay be your connection.", error] : result.bestTranscription.formattedString;

					if (self.alert) {
						[self.alert dismissViewControllerAnimated:true completion:^() {
							[self transcriberCallback:message];
						}];
					} else {
						[self transcriberCallback:message];
					}
				}
			];
			
		} else {
			FUNCTION_tryDeleteFile(outFile);
			FUNCTION_simpleAlert(@"AudioToText Error:\n", [NSString stringWithFormat:@"Code: %i", result]);
			GLOBAL_IS_PROCESSING = false;
		}
	}

	-(void)transcriberCallback:(NSString *)message {
		self.alert = [UIAlertController alertControllerWithTitle:@"AudioToText Result:\n" message:message preferredStyle:UIAlertControllerStyleAlert];

		UIAlertAction* closeAction = [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault handler:nil];
		[self.alert addAction:closeAction];

		FUNCTION_presentAlert(self.alert, true);
	}

@end



%group GROUP_AUDIO_TO_TEXT

	%hook WAMessageAudioSliceView

	    %property (nonatomic, assign) BOOL pr0crustes_didConnectButton; // Make sure the button is only connected once.

		%new
		-(void)pr0crustes_doAudioToText {

			GLOBAL_IS_PROCESSING = true;

			WAChatCellData* data = MSHookIvar<WAChatCellData *>(self, "_lastCellData");
			NSString* fileIn = [[data message] mediaPath];

			Pr0crustes_Transcriber* transcriber = [Pr0crustes_Transcriber createInstance];
			[transcriber transcribeFile:fileIn];
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
