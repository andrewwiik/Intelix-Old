#import "MFMessage.h"

@interface MFMailMessage : MFMessage
-(NSString *)subject;
-(id)subjectNotIncludingReAndFwdPrefix;
-(BOOL)read;
@property (nonatomic,readonly) unsigned dateReceivedInterval;
@end