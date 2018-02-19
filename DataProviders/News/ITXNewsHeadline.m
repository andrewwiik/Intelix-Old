#import "ITXNewsHeadline.h"

@implementation ITXNewsHeadline
- (id)initWithHeadline:(FTHeadline *)headline {
	self = [super init];
	if (self) {
		if (headline) {
			_headline = headline;
			_sourceName = headline.sourceName;
			_publishDate = headline.publishDate;
			_url = headline.actionURL;
			_thumbnail = headline.thumbnail;
			_title = headline.title;
		} else return nil;
	}
	return self;
}
@end