#import <Intelix/ITXAnimationView.h>

@interface UIView (ITXAnimations)
- (BOOL)shouldForwardSelector:(SEL)aSelector;
- (id)forwardingTargetForSelector:(SEL)aSelector;
- (BOOL)_shouldAnimatePropertyWithKey:(NSString *)key;
@end

@implementation ITXAnimationView
- (BOOL)shouldForwardSelector:(SEL)aSelector {
    return [self.layer respondsToSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return (![self respondsToSelector:aSelector] && [self shouldForwardSelector:aSelector]) ? self.layer : self;
}

- (BOOL)_shouldAnimatePropertyWithKey:(NSString *)key {
    //if ([key isEqual:@"_continuousCornerRadius"] || [key isEqual:@"_setContinuousCornerRadius:"]) return YES;
    return ([self shouldForwardSelector:NSSelectorFromString(key)] || [super _shouldAnimatePropertyWithKey:key]);
}
@end