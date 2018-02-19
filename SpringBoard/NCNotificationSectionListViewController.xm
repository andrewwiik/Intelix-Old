#import <UserNotificationsUIKit/NCNotificationSectionListViewController.h>
#import <UserNotificationsUIKit/NCNotificationChronologicalList.h>
#import <Intelix/ITXNotificationListSectionFooterView.h>
#import <UIKit/UICollectionView+Private.h>
#import <UserNotificationsUIKit/NCNotificationListCell.h>
#import <UserNotificationsKit/NCNotificationRequest.h>

%hook NCNotificationSectionListViewController


// #pragma lockscreen support
// %new
// -(void)fadeIn {

// }

// -(void)clearAll {

// }

// %new
// -(BOOL)shouldAddHintTextForNotificationViewController:(id)arg1 {
// 	return NO;
// }

// #pragma mark end LS Support

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(NCNotificationListCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath  {
	cell.hasFooterUnder = [self.sectionList sectionHasFooter:[indexPath section]];
	cell.isLastInSection = [self collectionView:collectionView numberOfItemsInSection:[indexPath section]] - 1 == [indexPath row];
	cell._isFirstInSection = [indexPath row] == 0;
	//cell.hasFooterUnder = [self.sectionList sectionIsCollapsed:[indexPath section]];
	cell.cellOver = nil;
	cell.cellUnder = nil;
	%orig;
}

-(id)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath  {
	NCNotificationListCell *cell = %orig;
	cell.hasFooterUnder = [self.sectionList sectionHasFooter:[indexPath section]];
	cell.isLastInSection = [self collectionView:collectionView numberOfItemsInSection:[indexPath section]] - 1 == [indexPath row];
	cell._isFirstInSection = [indexPath row] == 0;
	//cell.hasFooterUnder = [self.sectionList sectionIsCollapsed:[indexPath section]];
	cell.cellOver = nil;
	cell.cellUnder = nil;
	return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(NCNotificationListCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath  {
	%orig;
	cell.hasFooterUnder = [self.sectionList sectionHasFooter:[indexPath section]];
	int numInSection = [self collectionView:collectionView numberOfItemsInSection:[indexPath section]];
	cell.isLastInSection = numInSection - 1 == [indexPath row];
	cell._isFirstInSection = [indexPath row] == 0;
	//cell.hasFooterUnder = [self.sectionList sectionIsCollapsed:[indexPath section]];
	cell.cellOver = nil;
	cell.cellUnder = nil;
}

-(UIView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	if (kind == UICollectionElementKindSectionFooter) {
		if ([self.sectionList sectionHasFooter:[indexPath section]]) {
			ITXNotificationListSectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NotificationListSectionHFooterReuseIdentifier" forIndexPath:indexPath];
			footerView.numberToShow = [self.sectionList actualNumberOfNotificationsInSection:[indexPath section]] - 3;
			footerView.cellDelegate = self;
			footerView.sectionIdentifier = [self.sectionList otherSectionIdentifierForSectionIndex:[indexPath section]];
			footerView.isExpanded = [self.sectionList sectionIsExpanded:[indexPath section]];
			return footerView;
		}
	} else if (kind == UICollectionElementKindSectionHeader) {
		return %orig;
	}
	return nil;
}


%new
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
	if ([self.sectionList sectionHasFooter:section]) {
		return CGSizeMake(collectionView.frame.size.width - 8*2, 36);
	} else return CGSizeZero;
}

- (void)viewDidLoad {
	%orig;
	[[self collectionView] registerClass:[ITXNotificationListSectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"NotificationListSectionHFooterReuseIdentifier"];
}

%new
-(void)sectionFooterView:(ITXNotificationListSectionFooterView *)footerView didReceiveToggleExpansionActionForSectionIdentifier:(NSString *)sectionIdentifier {
	[self.sectionList toggleExpansionForSectionIdentifier:sectionIdentifier];
}

- (void)notificationSectionList:(NCNotificationChronologicalList *)sectionList didInsertNotificationRequest:(NCNotificationRequest *)request atIndexPath:(NSIndexPath *)path {
	[self _performCollectionViewOperationBlockIfNecessary:^{
		NSUInteger section = [path section];
		if ([self.sectionList sectionIsCollapsed:section]) {
			[[self collectionView] reloadSections:[NSIndexSet indexSetWithIndex:section]];
		} else {
			[[self collectionView] insertItemsAtIndexPaths:[NSArray arrayWithObjects:path,nil]];
		}
	}];
}

- (void)notificationSectionList:(NCNotificationChronologicalList *)sectionList didRemoveNotificationRequest:(NCNotificationRequest *)request atIndexPath:(NSIndexPath *)path {
	[self _performCollectionViewOperationBlockIfNecessary:^{
		NSUInteger section = [path section];
		if ([self.sectionList sectionIsCollapsed:section]) {
			NSMutableArray *indexPaths = [NSMutableArray new];

			for (int x =[path row]; x < 3; x++) {
				[indexPaths addObject:[NSIndexPath indexPathForRow:x inSection:section]];
			}
			[[self collectionView] reloadItemsAtIndexPaths:[indexPaths copy]];
		} else {
			[[self collectionView] deleteItemsAtIndexPaths:[NSArray arrayWithObjects:path,nil]];
		}
	}];
}

%new
- (void)notificationSectionList:(NCNotificationChronologicalList *)sectionList didInsertNotificationRequests:(NSArray<NCNotificationRequest *> *)requests atIndexPaths:(NSArray<NSIndexPath *> *)paths reloadIndexPaths:(NSArray<NSIndexPath *> *)reloadPaths {
	[self _performCollectionViewOperationBlockIfNecessary:^{
		[[self collectionView] insertItemsAtIndexPaths:[paths copy]];
		for (NSIndexPath *path in reloadPaths) {
			int numInSection = [self.sectionList rowCountForSectionIndex:[path section]];
			NCNotificationListCell *cell = (NCNotificationListCell *)[[self collectionView] cellForItemAtIndexPath:path];
			if (cell) {
				cell.hasFooterUnder = [self.sectionList sectionHasFooter:[path section]];
				cell.isLastInSection = numInSection - 1 == [path row];
				cell._isFirstInSection = [path row] == 0;
				cell.cellOver = nil;
				cell.cellUnder = nil;
			}
		}
		if ([reloadPaths count] > 0) {
			NSUInteger section = [[reloadPaths objectAtIndex:0] section];
			ITXNotificationListSectionFooterView *footer = (ITXNotificationListSectionFooterView *)[[self collectionView] _visibleSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
			if (footer) {
				footer.isExpanded = [self.sectionList sectionIsExpanded:section];
			}
		}
		//[[self collectionView] reloadItemsAtIndexPaths:[paths copy]];
	}];
}

%new
- (void)notificationSectionList:(NCNotificationChronologicalList *)sectionList didRemoveNotificationRequests:(NSArray<NCNotificationRequest *> *)requests atIndexPaths:(NSArray<NSIndexPath *> *)paths  reloadIndexPaths:(NSArray<NSIndexPath *> *)reloadPaths {
	[self _performCollectionViewOperationBlockIfNecessary:^{
		[[self collectionView] deleteItemsAtIndexPaths:[paths copy]];
		for (NSIndexPath *path in reloadPaths) {
			int numInSection = [self.sectionList rowCountForSectionIndex:[path section]];
			NCNotificationListCell *cell = (NCNotificationListCell *)[[self collectionView] cellForItemAtIndexPath:path];
			if (cell) {
				cell.hasFooterUnder = [self.sectionList sectionHasFooter:[path section]];
				cell.isLastInSection = numInSection - 1 == [path row];
				cell._isFirstInSection = [path row] == 0;
				cell.cellOver = nil;
				cell.cellUnder = nil;
			}
		}

		if ([reloadPaths count] > 0) {
			NSUInteger section = [[reloadPaths objectAtIndex:0] section];
			ITXNotificationListSectionFooterView *footer = (ITXNotificationListSectionFooterView *)[[self collectionView] _visibleSupplementaryViewOfKind:@"UICollectionElementKindSectionFooter" atIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
			if (footer) {
				footer.isExpanded = [self.sectionList sectionIsExpanded:section];
			}
			// footer.isExpanded = [self.sectionList sectionIsExpanded:section];
		}
		//[[self collectionView] reloadItemsAtIndexPaths:[paths copy]];
	}];
}

// - (void)_configureMainOverlayViewIfNecessary {
// 	return;
// }
// -(BOOL)isHeaderHidden {
// 	return YES;
// }
%end