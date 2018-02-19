@interface ITXUnifiedNotificationsView : UIView
- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius;
- (void)setRevealPercentage:(CGFloat)percentage;
- (void)setMiddleTop:(CGFloat)top andMiddleBottom:(CGFloat)bottom;
@end