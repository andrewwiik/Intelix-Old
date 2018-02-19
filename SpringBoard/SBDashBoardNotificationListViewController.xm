#import <UserNotificationsUIKit/NCNotificationSectionListViewController.h>


@interface SBDashBoardNotificationListViewController : UIViewController {
	NCNotificationSectionListViewController* _listViewController;
}
@property (nonatomic, retain) NCNotificationSectionListViewController *properListController;
-(void)registerView:(id)arg1 forRole:(NSInteger)arg2 options:(NSUInteger)arg3;
@end

%hook SBDashBoardNotificationListViewController
%property (nonatomic, retain) NCNotificationSectionListViewController *properListController;

-(id)initWithNibName:(id)arg1 bundle:(id)arg2 {
	SBDashBoardNotificationListViewController *orig = %orig;
	if (orig) {
		orig.properListController = [[NSClassFromString(@"NCNotificationSectionListViewController") alloc] init];
		orig.properListController.destinationDelegate = self;
		orig.properListController.userInteractionDelegate = self;
	}
	return orig;
}

- (void)viewDidLoad {
	%orig;
	[self addChildViewController:self.properListController];
	[self registerView:[self.properListController collectionView] forRole:2 options:1];
}

- (void)viewWillLayoutSubviews {
	%orig;
	CGRect listViewFrame = self.properListController.view.frame;
	CGRect otherListViewFrame = ((NCNotificationSectionListViewController *)[self valueForKey:@"_listViewController"]).view.frame;
	self.properListController.view.frame = CGRectMake(otherListViewFrame.origin.x, otherListViewFrame.origin.y,listViewFrame.size.height,listViewFrame.size.width);
}
%end


