@interface WAContactTableViewCell : UITableViewCell {
        // The contact JID.
        NSString *_jid;
        // The contact imageView.
        WAProfilePictureDynamicThumbnailView *_imageViewContact;
    }

    // Method from UIView, almost a viewDidLoad.
    -(void)layoutSubviews;

    // New
    @property (nonatomic, retain) CAShapeLayer* pr0crustes_circleLayer;// Method from UIView, almost a viewDidLoad.
@end
