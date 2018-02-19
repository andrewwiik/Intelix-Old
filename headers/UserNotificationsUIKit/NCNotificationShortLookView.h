@interface NCNotificationShortLookView : UIView {
	UIView *_mainOverlayView;
}
@property (nonatomic, retain) UIView *backgroundView;
- (BOOL)isBanner;
@end