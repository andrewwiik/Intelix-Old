#import "NCNotificationChronologicalList.h"
#import <Intelix/ITXNotificationListSectionFooterView.h>
#import <UserNotificationsKit/NCNotificationRequest.h>
#import "NCNotificationListViewController.h"

@interface NCNotificationSectionListViewController : NCNotificationListViewController
@property (nonatomic,retain) NCNotificationChronologicalList *sectionList;  
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section;
- (void)_performCollectionViewOperationBlockIfNecessary:(void (^)())block;
@end

@interface NCNotificationSectionListViewController (Intelix)
- (void)sectionFooterView:(ITXNotificationListSectionFooterView *)footerView didReceiveToggleExpansionActionForSectionIdentifier:(NSString *)sectionIdentifier;
- (void)notificationSectionList:(NCNotificationChronologicalList *)sectionList didInsertNotificationRequests:(NSArray<NCNotificationRequest *> *)requests atIndexPaths:(NSArray<NSIndexPath *> *)paths reloadIndexPaths:(NSArray<NSIndexPath *> *)reloadPaths;
- (void)notificationSectionList:(NCNotificationChronologicalList *)sectionList didRemoveNotificationRequests:(NSArray<NCNotificationRequest *> *)requests atIndexPaths:(NSArray<NSIndexPath *> *)paths reloadIndexPaths:(NSArray<NSIndexPath *> *)reloadPaths;
@end
