@interface WAContactTableViewCell : UITableViewCell {
        NSString *_jid;
        WAProfilePictureDynamicThumbnailView *_imageViewContact;
    }

    -(void)layoutSubviews;
@end
