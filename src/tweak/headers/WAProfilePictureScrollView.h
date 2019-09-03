
@interface WAProfilePictureScrollView : UIScrollView
	@property(retain, nonatomic) UIImageView *imageView;
	-(void)layoutSubviews;
	// new
	-(void)pr0crustes_handleHoldGesture:(UILongPressGestureRecognizer *)gesture;
@end
