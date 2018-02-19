
#import "ITXUnifiedNotificationsView.h"

@interface UIView (ITXAnimations)
- (BOOL)shouldForwardSelector:(SEL)aSelector;
- (id)forwardingTargetForSelector:(SEL)aSelector;
- (BOOL)_shouldAnimatePropertyWithKey:(NSString *)key;
@end

@interface CALayer (ITXPrivate)
@property (copy) NSString * groupName; 
@property (nonatomic, assign) CGFloat scale;
@end


@interface BackdropView : UIView
@end

@interface NCMaterialView : UIView {
	BackdropView *_backdropView;
}
@property (nonatomic,copy) NSString * groupName; 
-(id)initWithStyleOptions:(NSUInteger)arg1 ;
@end

%hook UIView
%new
- (void)addSeperatedCornersView {
	ITXUnifiedNotificationsView *view = [[ITXUnifiedNotificationsView alloc] initWithFrame:CGRectMake(8-359,100,359*2,273)];
	//view.backgroundColor = [UIColor greenColor];
	// NCMaterialView *other = [[NSClassFromString(@"NCMaterialView") alloc] initWithStyleOptions:4];
	// [self addSubview:other];

	// other.frame = CGRectMake(0,0,1,1);
	// other.groupName = @"ITXTest";
	// other.clipsToBounds = YES;
	[self addSubview:view];
}

// - (BOOL)shouldForwardSelector:(SEL)aSelector {
//     return [self.layer respondsToSelector:aSelector];
// }

// - (id)forwardingTargetForSelector:(SEL)aSelector {
//     return (![self respondsToSelector:aSelector] && [self shouldForwardSelector:aSelector]) ? self.layer : self;
// }

// - (BOOL)_shouldAnimatePropertyWithKey:(NSString *)key {
//     //if ([key isEqual:@"_continuousCornerRadius"] || [key isEqual:@"_setContinuousCornerRadius:"]) return YES;
//     return ([self shouldForwardSelector:NSSelectorFromString(key)] || %orig);
// }
%end

%hook SpringBoard
%new
- (BOOL)loadMobileMailDataProvider {

	NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/Intelix/DataProviders/ITXMobileMailProvider.bundle"];
	NSError *error = nil;
	BOOL didLoad = [bundle loadAndReturnError:&error];
	if (!didLoad) {
		HBLogError(@"Error Loading Mail Data Provider: %@", error);
	}
	return didLoad;
}

%new
- (BOOL)loadNewsDataProvider {

	NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/Intelix/DataProviders/ITXNewsProvider.bundle"];
	NSError *error = nil;
	BOOL didLoad = [bundle loadAndReturnError:&error];
	if (!didLoad) {
		HBLogError(@"Error Loading News Data Provider: %@", error);
	}
	return didLoad;
}
%end

%ctor {
	%init;
}