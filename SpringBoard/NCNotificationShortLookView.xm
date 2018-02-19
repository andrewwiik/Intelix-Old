#import <UserNotificationsUIKit/NCNotificationShortLookView.h>

%hook NCNotificationShortLookView
- (BOOL)usesBackgroundView {
	if (![self isBanner]) return NO;
	return %orig;
}
-(BOOL)isHeaderHidden {
	if (![self isBanner]) return YES;
	return %orig;
}
- (void)_configureMainOverlayViewIfNecessary {
	if (![self isBanner]) return;
	%orig;
}
%end