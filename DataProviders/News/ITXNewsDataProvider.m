#import "ITXNewsDataProvider.h"

#import <NewsToday/FTHeadlineSection.h>
#import <NewsToday/FTHeadline.h>

@implementation ITXNewsDataProvider

+ (ITXNewsDataProvider *)sharedInstance {
	static ITXNewsDataProvider *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ITXNewsDataProvider alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
	self = [super init];
	if (self) {
		_headlines = [NSMutableArray new];
		_newsSource = [[NSClassFromString(@"FTContentViewController") alloc] init];
		[_newsSource setNextUpdateTime:0];
		[self loadHeadlines];
	}
	return self;
}

- (void)loadHeadlines {
	[_newsSource _updateWidgetWithCompletionHandler:^{
		[[NSClassFromString(@"ITXNewsDataProvider") sharedInstance] headlinesLoaded];
	}];
}

- (void)headlinesLoaded {
	_headlines = [NSMutableArray new];
	int numOfSections = [_newsSource numberOfSectionsInTableView:nil];
	for (int x = 0; x < numOfSections; x++) {
		FTHeadlineSection *section = [_newsSource _sectionForSection:x];
		NSArray<FTHeadline *> *headlines = [section.headlines array];
		for (FTHeadline *headline in headlines) {
			[_headlines addObject:[[ITXNewsHeadline alloc] initWithHeadline:headline]];
		}
	}
}

- (NSUInteger)numberOfHeadlines {
	return [_headlines count];
}

- (ITXNewsHeadline *)headlineForIndex:(NSUInteger)index {
	if ([_headlines count] < 1) [self loadHeadlines];

	if (index < [_headlines count]) {
		return _headlines[index];
	} else return nil;
}

@end