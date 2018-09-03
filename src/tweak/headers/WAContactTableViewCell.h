@interface WAContactTableViewCell : UITableViewCell {
        NSString *_jid;
        WAProfilePictureDynamicThumbnailView *_imageViewContactPicture;
    }

    -(void)layoutSubviews;
@end
