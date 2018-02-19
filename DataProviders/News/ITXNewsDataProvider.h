#import <NewsToday/FTContentViewController.h>
#import "ITXNewsHeadline.h"

@interface ITXNewsDataProvider : NSObject
@property (nonatomic, retain, readwrite) FTContentViewController *newsSource;
@property (nonatomic, retain, readwrite) NSMutableArray<ITXNewsHeadline *> *headlines;
+ (instancetype)sharedInstance;
- (id)init;
- (void)loadHeadlines;
- (void)headlinesLoaded;
- (NSUInteger)numberOfHeadlines;
- (ITXNewsHeadline *)headlineForIndex:(NSUInteger)index;
@end