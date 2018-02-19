#import "MFMailMessage.h"

@interface MFLibraryMessage : MFMailMessage
-(void)_forceLoadOfMessageSummaryFromProtectedStore;
-(NSString *)messageID;
@end