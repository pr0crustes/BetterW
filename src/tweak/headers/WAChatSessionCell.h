#import "WAProfilePictureDynamicThumbnailView.h"

@interface WAChatSessionCell : UITableViewCell {
        NSString *_jid;
        WAProfilePictureDynamicThumbnailView *_imageViewContactPicture;
    }

    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;
	@property (nonatomic,assign) bool pr0crustes_previousState;
	@property (nonatomic,assign) bool pr0crustes_alreadyRunned;
@end
