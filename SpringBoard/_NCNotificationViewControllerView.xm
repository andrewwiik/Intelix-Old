#import <UserNotificationsUIKit/_NCNotificationViewControllerView.h>

%hook _NCNotificationViewControllerView
- (CGSize)sizeThatFits:(CGSize)arg1 {
	CGSize origSize = %orig;
	if (origSize.height > 36) {
		origSize.height -= 5;
	}
	return origSize;
}
%end