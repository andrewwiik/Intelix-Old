#import <Intelix/ITXBackdropView.h>

@implementation ITXBackdropView
+ (Class)layerClass {
	return NSClassFromString(@"CABackdropLayer");
}
@end