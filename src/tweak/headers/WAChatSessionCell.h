#import "WAProfilePictureDynamicThumbnailView.h"

@interface WAChatSessionCell : UITableViewCell {
        NSString *_jid;
        WAProfilePictureDynamicThumbnailView *_imageViewContactPicture;
    }

    -(void)layoutSubviews;
    // New
    -(void)pr0crustes_applyColorMask:(_Bool)isOnline;
@end
