#import "WAProfilePictureDynamicThumbnailView.h"
#import "WAChatSession.h"

@interface WAChatSessionCell : UITableViewCell {
        // The contact imageView. 
        WAProfilePictureDynamicThumbnailView *_imageViewContactPicture;
    }

    // The contact JID.
    @property(retain, nonatomic) WAChatSession *chatSession; // @synthesize chatSession=_chatSession;

    // Method from UIView, almost a viewDidLoad.
    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;  // Used to hold the dot shapeLayer.
@end
