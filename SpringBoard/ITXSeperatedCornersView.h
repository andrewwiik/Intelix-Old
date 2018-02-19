@interface ITXSeperatedCornersView : UIView
@property (nonatomic, assign) CGFloat clipValue;
- (id)initWithFrame:(CGRect)frame;
// - (void)setTopCornerRadius:(CGFloat)cornerRadius;
- (void)updateCornerFrames;
- (void)setTopRadius:(CGFloat)topRadius bottomRadius:(CGFloat)bottomRadius  withDelay:(int)delay;
- (void)setTopRadius:(CGFloat)topRadius;
- (void)setBottomRadius:(CGFloat)bottomRadius;
- (void)setContinousCornerRadius:(CGFloat)cornerRadius;
- (CGFloat)cornerRadiusBeingUsed;
- (void)setTopClipPercent:(CGFloat)topClipPercent;
- (void)setBottomClipPercent:(CGFloat)bottomClipPercent;
@end