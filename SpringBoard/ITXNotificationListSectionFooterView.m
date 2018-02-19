#import <Intelix/ITXNotificationListSectionFooterView.h>
#import <QuartzCore/CALayer+Private.h>
#import <QuartzCore/CAFilter+Private.h>

static CGFloat separatorHeight = 0;

@interface NCNotificationSectionListViewController : UICollectionViewController
-(void)sectionFooterView:(ITXNotificationListSectionFooterView *)footerView didReceiveToggleExpansionActionForSectionIdentifier:(NSString *)sectionIdentifier;
@end

@interface NCLookViewFontProvider : NSObject
+ (instancetype)lookViewPreferredFontProvider;
+ (instancetype)lookViewDefaultFontProvider;
- (UIFont *)nc_preferredFontForTextStyle:(id)textStyle hiFontStyle:(NSInteger)fontStyle;
@end


@implementation ITXNotificationListSectionFooterView
-(id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		if (separatorHeight == 0) {
			separatorHeight = 1.0f/[UIScreen mainScreen].scale;
		}
		// self.backgroundColor = [UIColor redColor];
		// self.itxBackgroundView = [[ITXSeperatedCornersView alloc] initWithFrame:self.bounds];
		// [self addSubview:self.itxBackgroundView];

		self.itxBackgroundView = [[ITXSeperatedCornersView alloc] initWithFrame:CGRectMake(8, 0, self.bounds.size.width - 8*2, self.bounds.size.height)];
		//self.itxBackgroundView.layer.scale = 0.25;
		self.itxBackgroundView.layer.groupName = @"ITXNCCellBackground";
		[self.itxBackgroundView setContinousCornerRadius:13];
		self.itxBackgroundView.clipValue = 4;
		
		NSMutableArray *filters = [NSMutableArray new];
		// CAFilter *filter = [NSClassFromString(@"CAFilter") filterWithType:@"gaussianBlur"];
		// [filter setValue:[NSNumber numberWithFloat:30] forKey:@"inputRadius"];
		// [filter setValue:@YES forKey:@"inputHardEdges"];
		// [filters addObject:filter];

		CAFilter *filter1 = [NSClassFromString(@"CAFilter") filterWithType:@"colorSaturate"];
		[filter1 setValue:[NSNumber numberWithFloat:2.0] forKey:@"inputAmount"];
		[filters addObject:filter1];

		[self.itxBackgroundView.layer setFilters:[filters copy]];
		self.itxBackgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.65];
		[self.itxBackgroundView setTopRadius:0.0 bottomRadius:1.0 withDelay:0];

		self.whiteOverlayView = [[UIView alloc] initWithFrame:self.itxBackgroundView.bounds];
		self.whiteOverlayView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.2];
		[self.itxBackgroundView addSubview:self.whiteOverlayView];

		[self addSubview:self.itxBackgroundView];

		// CGRect backgroundFrame = self.itxBackgroundView.frame;
		// CGFloat inset = 0.0;

		self.separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.itxBackgroundView.bounds.size.width, separatorHeight)];
		self.separatorView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];
		[self.itxBackgroundView addSubview:self.separatorView];
		self.layer.allowsGroupBlending = NO;

		self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleShowAllNotifications)];
		[self addGestureRecognizer:self.tapRecognizer];
		self.tapRecognizer.cancelsTouchesInView = NO;
		self.tapRecognizer.numberOfTouchesRequired = 1;
		self.userInteractionEnabled = YES;
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	self.itxBackgroundView.frame =  CGRectMake(8, 0, self.bounds.size.width - 8*2, self.bounds.size.height);
	self.whiteOverlayView.frame = self.itxBackgroundView.bounds;
	self.separatorView.frame = CGRectMake(0, 0, self.itxBackgroundView.bounds.size.width, separatorHeight);
	// if (_middleLabel) {
	// [_middleLabel sizeToFit];
	// _middleLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (void)setupMiddleLabel {
	if (!_middleLabel) {
		_middleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_middleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.75];
		_middleLabel.font = [[NSClassFromString(@"NCLookViewFontProvider") lookViewPreferredFontProvider] nc_preferredFontForTextStyle:UIFontTextStyleFootnote hiFontStyle:3];

		CAFilter *vibrancyFilter = [NSClassFromString(@"CAFilter") filterWithType:@"vibrantLight"];
		[vibrancyFilter setValue:[UIColor colorWithWhite:0.4 alpha:1] forKey:@"inputColor0"];
		[vibrancyFilter setValue:[UIColor colorWithWhite:0 alpha:0.3] forKey:@"inputColor1"];
		[vibrancyFilter setValue:[NSNumber numberWithBool:YES] forKey:@"inputReversed"];

		_middleLabel.layer.filters = [NSArray arrayWithObjects:vibrancyFilter, nil];
		[self addSubview:_middleLabel];

	}
}

- (void)setNumberToShow:(NSInteger)numToShow {
	if (numToShow != _numberToShow) {
		_numberToShow = numToShow;
		if (_isExpanded) {
			[self setLabelText:[NSString stringWithFormat:@"Show Less"]];
		} else {
			[self setLabelText:[NSString stringWithFormat:@"Show %d more", (int)_numberToShow]];
		}
		//[self setLabelText:[NSString stringWithFormat:@"Show %d more", (int)_numberToShow]];
	}
}

- (void)setLabelText:(NSString *)text {
	if (!_middleLabel) {
		[self setupMiddleLabel];
	}
	if (text != _middleLabel.text) {
		_middleLabel.text = text;
		[_middleLabel sizeToFit];
		_middleLabel.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
	}
}

- (void)setIsExpanded:(BOOL)isExpanded {
	if(_isExpanded != isExpanded) {
		_isExpanded = isExpanded;
		if (_isExpanded) {
			[self setLabelText:[NSString stringWithFormat:@"Show Less"]];
		} else {
			[self setLabelText:[NSString stringWithFormat:@"Show %d more", (int)_numberToShow]];
		}
	}

}

- (void)toggleShowAllNotifications {
	if (self.cellDelegate) {
		// self.isExpanded = !self.isExpanded;
		[self.cellDelegate sectionFooterView:self didReceiveToggleExpansionActionForSectionIdentifier:self.sectionIdentifier];
	}
	// if (self.backgroundColor == [UIColor redColor]) {
	// 	self.backgroundColor = [UIColor blueColor];
	// } else {
	// 	self.backgroundColor = [UIColor redColor];
	// }
}
@end