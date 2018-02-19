#import <Intelix/ITXSeperatedCornersView.h>
#import <QuartzCore/CALayer+Private.h>
#import <QuartzCore/CAFilter+Private.h>
#import <UserNotificationsUIKit/NCNotificationListCell.h>
#import <Intelix/ITXHasRoundedBackground-Protocol.h>
#import <UIKit/UICollectionViewCell+Private.h>
#import <UIKit/UICollectionView+Private.h>

static CGFloat separatorHeight = 0;

%hook NCNotificationListCell
%property (nonatomic, retain) ITXSeperatedCornersView *itxBackgroundView;
%property (nonatomic, retain) UIView *separatorView;
%property (nonatomic, assign) BOOL _isLastInSection;
%property (nonatomic, assign) BOOL _isFirstInSection;
%property (nonatomic, assign) BOOL hasFooterUnder;
%property (nonatomic, assign) CGFloat _cornerRadiusForCell;
%property (nonatomic, retain) UIView *cellOver;
%property (nonatomic, retain) UIView *cellUnder;
%property (nonatomic, retain) UIView *whiteOverlayView;


- (void)updateCellForContentViewController:(id)controller {

	// BOOL shouldAdd = [self valueForKey:@"_contentViewController"] != controller;
	// if (shouldAdd) {
	// 	if (self.itxBackgroundView) {
	// 		[self.itxBackgroundView removeFromSuperview]
	// 	}
	// }
	%orig;

	if (!self.itxBackgroundView) {

		if (separatorHeight == 0) {
			separatorHeight = 1.0f/[UIScreen mainScreen].scale;
		}

		self.itxBackgroundView = [[ITXSeperatedCornersView alloc] initWithFrame:CGRectMake(0, 0, self.contentViewController.view.frame.size.width, self.contentViewController.view.frame.size.height)];
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
		[self.itxBackgroundView setTopRadius:0.0 bottomRadius:0.0 withDelay:0];

		self.whiteOverlayView = [[UIView alloc] initWithFrame:self.itxBackgroundView.bounds];
		self.whiteOverlayView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:0.2];
		[self.itxBackgroundView addSubview:self.whiteOverlayView];

		self._cornerRadiusForCell = [self.itxBackgroundView cornerRadiusBeingUsed];

		[self.contentViewController.view addSubview:self.itxBackgroundView];
		[self.contentViewController.view sendSubviewToBack:self.itxBackgroundView];

		CGRect backgroundFrame = self.itxBackgroundView.frame;
		CGFloat inset = 15.0;

		self.separatorView = [[UIView alloc] initWithFrame:CGRectMake(inset, backgroundFrame.size.height - separatorHeight, backgroundFrame.size.width - inset, separatorHeight)];
		self.separatorView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.4];

		[self.itxBackgroundView addSubview:self.separatorView];
	}

	// if ([self.itxBackgroundView superview] != self.contentViewController.view) {
	// 	[self.itxBackgroundView removeFromSuperview];
	// 	[self.contentViewController.view addSubview:self.itxBackgroundView];
	// 	[self.contentViewController.view sendSubviewToBack:self.itxBackgroundView];
	// }

}


- (void)layoutSubviews {
	if (self.frame.size.height > 0) {
 		%orig;
 	}

	if (self.itxBackgroundView) {
		self.clipsToBounds = YES;
		CGFloat inset = 15.0;
		CGRect backgroundFrame = CGRectMake(0, 0, self.contentViewController.view.frame.size.width, self.contentViewController.view.frame.size.height);
		if (backgroundFrame.size.height > 0) {
			self.itxBackgroundView.frame = backgroundFrame;
			self.whiteOverlayView.frame = self.itxBackgroundView.bounds;
			self.separatorView.frame = CGRectMake(inset, backgroundFrame.size.height - separatorHeight, backgroundFrame.size.width - inset, separatorHeight);
		}
	}
}

-(void)scrollViewWillBeginDragging:(id)arg1 {
	%orig;
	self.cellOver = nil;
	self.cellUnder = nil;

	UICollectionView *collectionView = self.collectionView;
	NSIndexPath *currentIndexPath = [self.collectionView indexPathForCell:self];
	if (self._isLastInSection && self._isFirstInSection) {
		self.cellOver = (UIView *)[collectionView _visibleSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:[currentIndexPath section]]];
	} else if (self._isFirstInSection) {
		self.cellOver = (UIView *)[collectionView _visibleSupplementaryViewOfKind:@"UICollectionElementKindSectionHeader" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:[currentIndexPath section]]];
		self.cellUnder = (UIView *)[collectionView _visibleCellForIndexPath:[NSIndexPath indexPathForRow:[currentIndexPath row] + 1 inSection:[currentIndexPath section]]];
	} else if (self._isLastInSection) {
		self.cellOver = (UIView *)[collectionView _visibleCellForIndexPath:[NSIndexPath indexPathForRow:[currentIndexPath row] - 1 inSection:[currentIndexPath section]]];
	} else {
		self.cellOver = (UIView *)[collectionView _visibleCellForIndexPath:[NSIndexPath indexPathForRow:[currentIndexPath row] - 1 inSection:[currentIndexPath section]]];
		self.cellUnder = (UIView *)[collectionView _visibleCellForIndexPath:[NSIndexPath indexPathForRow:[currentIndexPath row] + 1 inSection:[currentIndexPath section]]];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	%orig;
	if (self.cellUnder || self.cellOver) {
		CGFloat percentComplete = fmaxf(fminf(fabs([scrollView contentOffset].x)/(self._cornerRadiusForCell*0.8), 1.0), 0.0);
		if (self.cellOver) {
			[((id<ITXHasRoundedBackground>)self.cellOver).itxBackgroundView setBottomRadius:percentComplete];
			[((id<ITXHasRoundedBackground>)self.cellOver).itxBackgroundView setBottomClipPercent:percentComplete];
		}

		if (self.cellUnder) {
			[((id<ITXHasRoundedBackground>)self.cellUnder).itxBackgroundView setTopRadius:percentComplete];
			[((id<ITXHasRoundedBackground>)self.cellUnder).itxBackgroundView setTopClipPercent:percentComplete];
		}

		if (self._isLastInSection) {
			[self.itxBackgroundView setTopRadius:percentComplete];
		} else {
			[self.itxBackgroundView setTopRadius:percentComplete bottomRadius:percentComplete withDelay:0];
		}
	}
}

%new
- (id)getTest {
	UICollectionView *collectionView = self.collectionView;
	NSIndexPath *currentIndexPath = [self.collectionView indexPathForCell:self];
	return [collectionView _visibleCellForIndexPath:[NSIndexPath indexPathForRow:[currentIndexPath row] - 1 inSection:[currentIndexPath section]]];
}

%new
- (BOOL)isLastInSection {
	return self._isLastInSection;
}

%new
- (void)setIsLastInSection:(BOOL)isLast {
	//if (isLast != self._isLastInSection) {
		self._isLastInSection = isLast;
		if (isLast) {
			if (!self.hasFooterUnder) {
				[self.itxBackgroundView setTopRadius:0 bottomRadius:1 withDelay:0.0];
			} else {
				[self.itxBackgroundView setTopRadius:0 bottomRadius:0 withDelay:0.0];
			}
			self.separatorView.hidden = YES;
		} else {
			[self.itxBackgroundView setTopRadius:0 bottomRadius:0 withDelay:0.0];
			self.separatorView.hidden = NO;
		}
	//}
}

- (void)prepareForReuse {
	%orig;
	if (self.itxBackgroundView) {
		[self.itxBackgroundView setBottomClipPercent:0];
		[self.itxBackgroundView setTopClipPercent:0];
		[self.itxBackgroundView setTopRadius:0 bottomRadius:0 withDelay:0];
	}
	self.cellOver = nil;
	self.cellUnder = nil;
	self.hasFooterUnder = NO;
	self.isLastInSection = NO;
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)attributes {
// 	if (attributes.size.height < 1) {
// 		attributes.transform = CGAffineTransformIdentity;
// 	}

	UICollectionViewLayoutAttributes *orig = %orig;
	orig.alpha = 1.0;
	return orig;
}

- (void)_setLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
	attributes.alpha = 1.0;
	attributes.transform = CGAffineTransformIdentity;
	%orig(attributes);
}

// 	if (attributes.size.height < 1) {
// 		layoutAttributes.alpha = 1.0;
// 		// layoutAttributes.trans
// 		layoutAttributes.transform = CGAffineTransformIdentity;
// 	//	CGRect frame = layoutAttributes.frame;
// 		layoutAttributes.center = CGPointMake(layoutAttributes.center.x, layoutAttributes.center.y - layoutAttributes.size.height/2);
// 		layoutAttributes.size = CGSizeMake(layoutAttributes.size.width, 0);
// 		//CGRect frame = layoutAttributes.frame;
// 		//frame.origin.y -= self.itxBackgroundView.bounds.size.height/2;
// 		//layoutAttributes.frame = frame;
// 		self.clipsToBounds = YES;
// 	}
// 	return layoutAttributes;

// }

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {
	// if (attributes.size.height < 1) {
	// 	attributes.alpha = 1.0;
	// 	attributes.center = CGPointMake(attributes.center.x, attributes.center.y - self.itxBackgroundView.bounds.size.height/2);
	// }
	CGRect frame = attributes.frame;
	frame.origin.x = 8;
	attributes.frame = frame;
	self.itxBackgroundView.alpha = 1.0;
	%orig(attributes);
	self.alpha = 1.0;
	self.itxBackgroundView.alpha = 1.0;
	self.transform = CGAffineTransformIdentity;
	// CGRectMake frane = self.frame;
	// if (attributes.size.height < 1) {
	// 	self.alpha = 1.0;
	// 	self.center = CGPointMake(self.center.x, self.center.y - self.itxBackgroundView.bounds.size.height/2);
	// }
}
// 	self.clipsToBounds = YES;
// 	// if (self.itxBackgroundView) {
// 	// 	if (layoutAttributes.frame.size.height < self.itxBackgroundView.bounds.size.height) self.clipsToBounds = YES;
// 	// 	else self.clipsToBounds = NO;
// 	// } else {
// 	// 	self.clipsToBounds = NO;
// 	// }


// 	// if (CGAffineTransformEqualToTransform(layoutAttributes.transform, CGAffineTransformMakeScale(5.0,1.0))) {
// 	// 	layoutAttributes.alpha = 1.0;
// 	// 	// layoutAttributes.trans
// 	// 	layoutAttributes.transform = CGAffineTransformIdentity;
// 	// 	layoutAttributes.size = CGSizeMake(layoutAttributes.size.width, 0);
// 	// }
// 	%orig;
// 	// self.clipsToBounds = YES;
// //	%orig;
// 	// self.clipsToBounds = NO;
// // 	// BOOL applyAlphaToContentView = YES;
// // 	// if (self.contentViewController && self.contentViewController.notificationViewControllerView) {
// // 	// 	if (layoutAttributes.alpha == 2.0) {
// // 	// 		if (self.contentViewController.notificationViewControllerView.contentView) {
// // 	// 			self.contentViewController.notificationViewControllerView.contentView.alpha = 0;
// // 	// 			// layoutAttributes.transform = CGAffineTransformIdentity;
// // 	// 			applyAlphaToContentView = NO;
// // 	// 		}
// // 	// 	}
// // 	// }

// // 	// if (layoutAttributes.alpha == 2.0) {
// // 	// 	layoutAttributes.alpha = 1.0;
// // 	// }

// // 	// 	self.contentViewController.notificationViewControllerView.view.alpha = layoutAttributes.transform.a - 2.0;
// // 	// 	layoutAttributes.transform = CGAffineTransformIdentity;
// // 	// 	// layoutAttributes.alpha = self.alpha;
// // 	// }
// // 	%orig;

// // 	// if (applyAlphaToContentView) {
// // 	// 	if (self.contentViewController && self.contentViewController.notificationViewControllerView) {
// // 	// 		if (self.contentViewController.notificationViewControllerView.contentView) {
// // 	// 			self.contentViewController.notificationViewControllerView.contentView.alpha = layoutAttributes.alpha;
// // 	// 			// layoutAttributes.transform = CGAffineTransformIdentity;
// // 	// 		}
// // 	// 	}
// // 	// }


// }
%end