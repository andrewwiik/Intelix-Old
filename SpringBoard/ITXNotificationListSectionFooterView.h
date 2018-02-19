#import "ITXSeperatedCornersView.h"

// @interface NCNotificationSectionListViewController : UICollectionViewController
// @property (nonatomic,retain) NCNotificationChronologicalList *sectionList;  
// - (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
// @end

@class NCNotificationSectionListViewController;

@interface ITXNotificationListSectionFooterView : UICollectionReusableView
@property (nonatomic, retain, readwrite) ITXSeperatedCornersView *itxBackgroundView;
@property (nonatomic, retain, readwrite) UIView *whiteOverlayView;
@property (nonatomic, retain, readwrite) UIView *separatorView;
@property (nonatomic, retain, readwrite) UILabel *middleLabel;
@property (nonatomic, assign, readwrite) NSInteger numberToShow;
@property (nonatomic, retain, readwrite) id<ITXFooterCellDelegate> cellDelegate;
@property (nonatomic, retain, readwrite) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, retain, readwrite) NSString *sectionIdentifier;
@property (nonatomic, assign, readwrite) BOOL isExpanded;
- (void)setLabelText:(NSString *)text;
- (void)setupMiddleLabel;
- (void)toggleShowAllNotifications;
@end