@interface WAContactTableViewCell : UITableViewCell {
        NSString *_jid;  // The contact JID.
        WAProfilePictureDynamicThumbnailView *_imageViewContact;  // The contact imageView.
    }

    // Method from UIView, almost a viewDidLoad.
    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;// Method from UIView, almost a viewDidLoad.
@end
