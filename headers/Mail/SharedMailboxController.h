#import "MFMailboxUid.h"

@interface SharedMailboxController : NSObject {
	NSArray<MFMailboxUid *> *_mailboxes;
}
// I guess we want source type 7 for the today box
+ (instancetype)sharedInstanceForSourceType:(NSUInteger)sourceType;
@end