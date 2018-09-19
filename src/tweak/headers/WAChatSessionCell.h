#import "WAProfilePictureDynamicThumbnailView.h"

@interface WAChatSessionCell : UITableViewCell {
        NSString *_jid;  // The contact JID.
        WAProfilePictureDynamicThumbnailView *_imageViewContactPicture;  // The contact imageView. 
    }

    // Method from UIView, almost a viewDidLoad.
    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;  // Used to hold the dot shapeLayer.
@end
