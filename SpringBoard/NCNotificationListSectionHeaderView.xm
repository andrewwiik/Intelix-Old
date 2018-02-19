#import <UserNotificationsUIKit/NCNotificationListSectionHeaderView.h>
#import <QuartzCore/CAFilter+Private.h>
#import <QuartzCore/CALayer+Private.h>
#import <Intelix/ITXSeperatedCornersView.h>
#import <UserNotificationsUIKit/NCLookHeaderContentView.h>

#import <SpringBoard/SpringBoard+Private.h>

@class NCNotificationSectionListViewController;

extern "C" NSData* SBSCopyIconImagePNGDataForDisplayIdentifier(NSString * bundleid);

SBIcon* iconForBundleID(NSString *bundleID) {
	SBIconController *iconController;
    if (!iconController) {
        if ([NSClassFromString(@"SBIconController") respondsToSelector:@selector(sharedInstance)]) {
            iconController = [NSClassFromString(@"SBIconController") sharedInstance];
        }
    }

    if ([iconController respondsToSelector:@selector(model)]) {

        SBIconModel *iconModel = [iconController model];
        if ([iconModel respondsToSelector:@selector(expectedIconForDisplayIdentifier:)]) {

            SBIcon *icon = [iconModel expectedIconForDisplayIdentifier:bundleID];
            if (icon && [icon isKindOfClass:NSClassFromString(@"SBIcon")]) {

                return icon;
            }
        }
    }

    return nil;
}

UIImage* iconImageForDisplayIdentifier(NSString *displayIdentifier) {

	SBIcon *icon = iconForBundleID(displayIdentifier);
	if (icon) {
		return (UIImage *)[icon getIconImage:1];
		//return [[iconView _iconImageView] contentsImage];
	}
	return nil;
	// NSData *icondata = SBSCopyIconImagePNGDataForDisplayIdentifier(displayIdentifier);
	// return [UIImage imageWithData:icondata];
}


%hook NCNotificationListSectionHeaderView
%property (nonatomic, retain) NSString *appIdentifier;
%property (nonatomic, retain) UIImageView *iconView;
%property (nonatomic, retain) UIImage *iconImage;
%property (nonatomic, retain) ITXSeperatedCornersView *itxBackgroundView;
%property (nonatomic, retain) NCLookHeaderContentView *headerContentView;

- (id)initWithFrame:(CGRect)frame {
	NCNotificationListSectionHeaderView *orig = %orig;
	if (orig) {

		orig.headerContentView = [[NSClassFromString(@"NCLookHeaderContentView") alloc] initWithStyle:0];
		orig.headerContentView.isITXView = YES;
		CGSize prefHeaderFrame = [orig.headerContentView sizeThatFits:CGSizeZero];
		CGRect headerFrame = CGRectMake(8,frame.size.height - prefHeaderFrame.height, frame.size.width - (8*2), prefHeaderFrame.height);
		orig.headerContentView.frame = headerFrame;
		[self addSubview:orig.headerContentView];

		orig.itxBackgroundView = [[ITXSeperatedCornersView alloc] initWithFrame:headerFrame];
		orig.itxBackgroundView.clipValue = 4;
		// orig.itxBackgroundView.backgroundColor
		//orig.backgroundView.layer.scale = 0.25;
		orig.itxBackgroundView.layer.groupName = @"ITXNCCellBackground";
		[orig.itxBackgroundView setContinousCornerRadius:13];

		UIView *whiterOverlay = [[UIView alloc] initWithFrame:orig.itxBackgroundView.bounds];
		whiterOverlay.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.35];
		[orig.itxBackgroundView addSubview:whiterOverlay];
		
		NSMutableArray *filters = [NSMutableArray new];
		// CAFilter *filter = [NSClassFromString(@"CAFilter") filterWithType:@"gaussianBlur"];
		// [filter setValue:[NSNumber numberWithFloat:30] forKey:@"inputRadius"];
		// [filter setValue:@YES forKey:@"inputHardEdges"];
		// [filters addObject:filter];

		CAFilter *filter1 = [NSClassFromString(@"CAFilter") filterWithType:@"colorSaturate"];
		[filter1 setValue:[NSNumber numberWithFloat:2.0] forKey:@"inputAmount"];
		[filters addObject:filter1];

		[orig.itxBackgroundView.layer setFilters:[filters copy]];
		orig.itxBackgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.65];
		[orig.itxBackgroundView setTopRadius:1.0 bottomRadius:0.0 withDelay:0];

		[orig addSubview:orig.itxBackgroundView];
		[orig sendSubviewToBack:orig.itxBackgroundView];

		// orig.headerContentView = [[NSClassFromString(@"NCLookHeaderContentView") alloc] initWithStyle:0];
		// orig.headerContentView.f

	}
	return orig;
}

- (void)layoutSubviews {
	%orig;
	if (self.clearButton) self.clearButton.hidden = YES;
	self.titleLabel.hidden = YES;
	CGSize prefHeaderFrame = [self.headerContentView sizeThatFits:CGSizeZero];
	CGRect headerFrame = CGRectMake(8,self.frame.size.height - prefHeaderFrame.height, self.frame.size.width - (8*2), prefHeaderFrame.height);
	self.itxBackgroundView.frame = headerFrame;
	self.headerContentView.frame = headerFrame;
}

- (void)setTitle:(NSString *)title forSectionIdentifier:(NSString *)sectionIdentifier {
	if (title) {
		NSArray *componets = [title componentsSeparatedByString:@"|"];
		if (componets.count > 1) {
			self.appIdentifier = componets[1];
		}
		title = componets[0];
	} else {
		self.appIdentifier = @"";
	}
	self.iconImage = iconImageForDisplayIdentifier(self.appIdentifier);
	// self.titleLabel.text = 
	// %orig(title, sectionIdentifier);
	[self setSectionIdentifier:sectionIdentifier];
	[self.headerContentView setTitle:title];
	[self.headerContentView setIcon:self.iconImage];

}
- (void)_layoutTitleLabelWithScale:(CGFloat)scale {
	return;
	// %orig;
}

+ (CGFloat)headerHeight {
	return %orig;
}
%end