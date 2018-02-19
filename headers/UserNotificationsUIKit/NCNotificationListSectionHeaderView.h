#import <Intelix/ITXSeperatedCornersView.h>
#import <UserNotificationsUIKit/NCLookHeaderContentView.h>

@interface NCNotificationListSectionHeaderView : UIView
@property (nonatomic,retain) UIButton *clearButton;  
@property (nonatomic,retain) UILabel * titleLabel;
- (void)setSectionIdentifier:(id)arg1;
@end

@interface NCNotificationListSectionHeaderView (Intelix)
@property (nonatomic, retain) NSString *appIdentifier;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, retain) UIImage *iconImage;
@property (nonatomic, retain) ITXSeperatedCornersView *itxBackgroundView;
@property (nonatomic, retain) NCLookHeaderContentView *headerContentView;
@end