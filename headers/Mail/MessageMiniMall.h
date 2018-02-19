#import "MailboxSource.h"
#import <Message/MFLibraryMessage.h>

@interface MessageMiniMall : NSObject
- (id)initWithObserver:(id)observer tag:(NSUInteger)tag;
- (void)addSource:(MailboxSource *)source;
- (NSSet<MailboxSource *> *)sources;
- (void)replaceAllSourcesWith:(NSSet<MailboxSource *> *)sources;
- (NSComparator)comparator;
- (void)setComparator:(NSComparator)comparator;
- (void)_loadMessages;
- (MFLibraryMessage *)messageAtTableIndexPath:(NSIndexPath *)path;
@end