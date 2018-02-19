#import <Intelix/ITXSeperatedCornersView.h>
#import "NCNotificationShortLookViewController.h"

@interface NCNotificationListCell : UICollectionViewCell
@property (nonatomic, retain) NCNotificationShortLookViewController *contentViewController;
-(CGFloat)_logicalContentOffsetForAbsoluteOffset:(CGPoint)arg1 ;

@end

@interface NCNotificationListCell (Intelix)
@property (nonatomic, retain) ITXSeperatedCornersView *itxBackgroundView;
@property (nonatomic, retain) UIView *separatorView;
@property (nonatomic, assign) BOOL isLastInSection;
@property (nonatomic, assign) BOOL _isLastInSection;
@property (nonatomic, assign) BOOL _isFirstInSection;
@property (nonatomic, assign) CGFloat _cornerRadiusForCell;
@property (nonatomic, retain) UIView *cellOver;
@property (nonatomic, retain) UIView *cellUnder;
@property (nonatomic, retain) UIView *whiteOverlayView;
@property (nonatomic, assign) BOOL hasFooterUnder;
@end
