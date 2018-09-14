#import "WAProfilePictureDynamicThumbnailView.h"

@interface WAChatSessionCell : UITableViewCell {
        NSString *_jid;
        WAProfilePictureDynamicThumbnailView *_imageViewContactPicture;
    }

    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;
@end
