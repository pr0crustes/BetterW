#import "WAChatJID.h"
#import "WAProfilePictureDynamicThumbnailView.h"

@interface WAContactTableViewCell : UITableViewCell {
        // The contact imageView.
        WAProfilePictureDynamicThumbnailView *_imageViewContact;
    }

    // The contact JID.
    @property(retain, nonatomic) WAChatJID *profilePictureJID;

    // Method from UIView, almost a viewDidLoad.
    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;// Method from UIView, almost a viewDidLoad.
@end
