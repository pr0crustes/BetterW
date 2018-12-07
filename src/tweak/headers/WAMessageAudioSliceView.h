#import "WAChatCellData.h"

@interface WAMessageAudioSliceView : UIView {
		WAChatCellData *_lastCellData;
		UIButton *_playPauseButton;
	}

	// Method from UIView, almost a viewDidLoad.
    -(void)layoutSubviews;

	// New
	-(void)pr0crustes_onButtonHold:(UILongPressGestureRecognizer *)recognizer;
    @property (nonatomic, assign) BOOL pr0crustes_didConnectButton; // Make sure the button is only connected once.
@end
