#import "WAProfilePictureDynamicThumbnailView.h"

@interface WAChatSessionCell : UITableViewCell {
        // The contact JID.
        NSString *_jid;
        // The contact imageView. 
        WAProfilePictureDynamicThumbnailView *_imageViewContactPicture;
    }

    // Method from UIView, almost a viewDidLoad.
    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;  // Used to hold the dot shapeLayer.
@end
