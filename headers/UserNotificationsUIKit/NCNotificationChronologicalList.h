#import "NCNotificationListSection.h"

@class NCNotificationSectionListViewController;
@interface NCNotificationChronologicalList : NSObject
@property (nonatomic,retain) NSMutableArray<NCNotificationListSection *> *sections;
//@property (nonatomic,retain) NSMutableArray<NCNotificationListSection *> *sections; 
- (NSMutableArray<NCNotificationListSection *> *)sections;
// @property (nonatomic,retain) NCNotificationHiddenRequestsList *hiddenRequestsList;
- (NSUInteger)rowCountForSectionIndex:(NSUInteger)index;
@property (nonatomic, retain) NCNotificationSectionListViewController *delegate; 
// - (id)setDelegate:(id)delegate;
// - (NCNotificationSectionListViewController *)delegate;
@end

@interface NCNotificationChronologicalList (Intelix)
@property (nonatomic, retain) NSMutableArray *collapsedSectionIdentifiers;
@property (nonatomic, retain) NSMutableArray *expandedSectionIdentifiers;
- (BOOL)sectionIsCollapsed:(NSUInteger)section;
- (BOOL)sectionIsExpanded:(NSUInteger)sectionIndex;
- (NSUInteger)actualNumberOfNotificationsInSection:(NSUInteger)section;
- (NSString *)otherSectionIdentifierForSectionIndex:(NSUInteger)section;
- (void)toggleExpansionForSectionIdentifier:(NSString *)sectionIdentifier;
- (BOOL)sectionHasFooter:(NSUInteger)sectionIndex;
- (NSUInteger)sectionIndexForOtherSectionIdentifier:(NSString *)otherSectionIdentifier;
@end
