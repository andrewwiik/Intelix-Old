
#import "FTHeadline.h"

@interface FTHeadlineSection : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSOrderedSet<FTHeadline *> *headlines;
@end