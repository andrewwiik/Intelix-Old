%hook NCNotificationContentView
- (UIEdgeInsets)_contentInsetsForShortLook {
	UIEdgeInsets orig = %orig;
	orig.top = 32;
	orig.bottom = 19;
	return orig;
}
%end