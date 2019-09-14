#import "headers/WAProfilePictureScrollView.h"

#import "_Pr0_Utils.h"


%group GROUP_PROFILE_IMAGE_SAVER

	%hook WAProfilePictureScrollView

		-(void)layoutSubviews {
			%orig;

			UIImageView* imageView = [self imageView];
			if (imageView) {
				[imageView setUserInteractionEnabled:YES];

				UILongPressGestureRecognizer *handler = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pr0crustes_handleHoldGesture:)];
				handler.minimumPressDuration = 1;
				[imageView addGestureRecognizer:handler];
			}
		}

		%new
		-(void)pr0crustes_handleHoldGesture:(UILongPressGestureRecognizer *)gesture {
			if(gesture.state == UIGestureRecognizerStateBegan) {
				UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Save Image?" message:@"" preferredStyle:UIAlertControllerStyleAlert];

				UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { 
					UIImageView* imageView = [self imageView];
					if (imageView) {
						UIImage* image = [imageView image];
						if (image) {
							UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
						}
					}
				}];
				[alert addAction:yesAction];

				UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
				[alert addAction:noAction];

				F_presentAlert(alert, true);
			}
		}

	%end

%end



%ctor {

	if (F_prefGetBool(@"pref_profile_image_saver")) {
		F_logEnabling(@"Profile Image Saver");
		%init(GROUP_PROFILE_IMAGE_SAVER);
	}

}
