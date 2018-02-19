#import <UserNotificationsUIKit/NCLookHeaderContentView.h>

%hook NCLookHeaderContentView 
%property (nonatomic, assign) BOOL isITXView;

- (void)_layoutIconButtonForShortLookWithScale:(CGFloat)scale {
	%orig;
	if (self.icon && self.isITXView) {
		CGSize iconSize = self.icon.size;
		CGFloat originY = self.frame.size.height - 8 - iconSize.height;
		self.iconButton.frame = CGRectMake(8,originY,iconSize.width,iconSize.height);
	}
}

- (void)_layoutTitleLabelForShortLookWithScale:(CGFloat)scale {
	%orig;
	if (self.icon && self.isITXView) {
		UILabel *titleLabel = [self _titleLabel];
		CGSize iconSize = self.icon.size;
		CGRect currentFrame = titleLabel.frame;
		currentFrame.origin.x = 8 + 6 + iconSize.width;
		titleLabel.frame = currentFrame;
	}
}

%end