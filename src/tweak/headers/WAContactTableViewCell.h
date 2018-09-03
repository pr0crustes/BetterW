@interface WAContactTableViewCell : UITableViewCell {
        NSString *_jid;
        WAProfilePictureDynamicThumbnailView *_imageViewContact;
    }

    -(void)layoutSubviews;

    // New
	@property (nonatomic,assign) bool pr0crustes_previousState;
	@property (nonatomic,assign) bool pr0crustes_alreadyRunned;
@end
