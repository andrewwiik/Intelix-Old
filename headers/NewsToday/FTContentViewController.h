
#import "FTHeadlineSection.h"

@interface FTContentViewController : UIViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (FTHeadlineSection *)_sectionForSection:(NSInteger)section;
- (void)widgetPerformUpdateWithCompletionHandler:(id)handler;
- (void)_updateWidgetWithCompletionHandler:(id)handler;
- (void)setNextUpdateTime:(NSUInteger)updateTime;
@end