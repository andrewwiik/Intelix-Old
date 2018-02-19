#import <UserNotificationsUIKit/NCNotificationListCollectionViewFlowLayout.h>

%hook NCNotificationListCollectionViewFlowLayout
-(CGFloat)minimumLineSpacing {
	return 0;
}
-(CGFloat)minimumInteritemSpacing {
	return 0;
}

- (UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
	UICollectionViewLayoutAttributes *attributes = %orig;
	if ([self.insertedIndexPaths containsObject:itemIndexPath]) {
		//attributes.alpha = 2.0;
		//attributes.size = CGSizeMake(attributes.size.width, 0);
		//CGAffineTransform transform = attributes.transform;
		//transform.a = 1.0;
		if ([itemIndexPath row] > 0) {
			UICollectionViewLayoutAttributes *aboveAttributes = %orig([NSIndexPath indexPathForRow:[itemIndexPath row] - 1 inSection:[itemIndexPath section]]);
			CGRect frame = aboveAttributes.frame;
			frame.origin.y += aboveAttributes.size.height;
			frame.origin.x = 8;
			frame.size.height = 0;
			frame.size.width = attributes.size.width;
			attributes.frame = frame;

		}
		//attributes.alpha = 2.0;
		//attributes.size = CGSizeMake(attributes.size.width, 0);
		//CGAffineTransform transform = attributes.transform;
		//transform.a = 1.0;
		//attributes.transform = CGAffineTransformMake(attributes.frame.origin.x, attributes.frame.origin, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty);
		attributes.alpha = 1.0;
		// self.clipsToBounds = YES;
	//	attributes.transform = CGAffineTransformMakeScale(5.0,1.0);
		//attributes.size = CGRectMake(0,0,attributes.bounds.size.width,0);
		// CGRect frame = attributes.frame;
		// // frame.origin.y -= frame.size.height;
		// frame.size.height = 0;
		// attributes.frame = frame;
		//CGRect frame = attributes.frame;
		//frame.size.height = 0;
		//attributes.frame = frame;
	}
	//attributeS = attributes;
	return attributes;
}

- (UICollectionViewLayoutAttributes *)finalLayoutAttributesForDisappearingItemAtIndexPath:(NSIndexPath *)itemIndexPath {
	UICollectionViewLayoutAttributes *attributes = %orig;
	// if ([itemIndexPath row] > 0) {
	// 	UICollectionViewLayoutAttributes *aboveAttributes = %orig([NSIndexPath indexPathForRow:[itemIndexPath row] - 1 inSection:[itemIndexPath section]]);
	// }
	//UICollectionViewLayoutAttributes *aboveAttributes

	if ([self.removedIndexPaths containsObject:itemIndexPath]) {
		if ([itemIndexPath row] > 0) {
			UICollectionViewLayoutAttributes *aboveAttributes = %orig([NSIndexPath indexPathForRow:[itemIndexPath row] - 1 inSection:[itemIndexPath section]]);
			CGRect frame = aboveAttributes.frame;
			frame.origin.y += aboveAttributes.size.height;
			frame.origin.x = 8;
			frame.size.height = 0;
			frame.size.width = attributes.size.width;
			attributes.frame = frame;

		}
		//attributes.alpha = 2.0;
		//attributes.size = CGSizeMake(attributes.size.width, 0);
		//CGAffineTransform transform = attributes.transform;
		//transform.a = 1.0;
		//attributes.transform = CGAffineTransformMake(attributes.frame.origin.x, attributes.frame.origin, CGFloat c, CGFloat d, CGFloat tx, CGFloat ty);
		attributes.alpha = 1.0;
		//attributes.size = CGSizeMake(attributes.size.width, 0);
		//attributes.transform = CGAffineTransformMakeScale(5.0,1.0);
		///attributes.center = CGPointMake(attributes.center.x, attributes.center.y - attributes.size.height/2);
		//attributes.size = CGSizeMake(attributes.size.width, 0);
		// CGRect frame = attributes.frame;
		// // frame.origin.y -= frame.size.height;
		// frame.size.height = 0;
		// attributes.frame = frame;
		//CGRect frame = attributes.frame;
		//frame.size.height = 0;
		//attributes.frame = frame;
	}
	//attributes.alpha = 1.0;
	// attributes.transform = CGAffineTransformIdentity;
	return attributes;
}

// %new
// - (UICollectionViewLayoutAttributes *)layoutAttributesForRow:(NSUInteger)row section:(NSUInteger)section {
// 	return [self initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
// }
%end