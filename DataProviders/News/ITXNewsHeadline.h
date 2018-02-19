#import <NewsToday/FTHeadline.h>

@interface ITXNewsHeadline : NSObject
@property (nonatomic, retain, readwrite) NSString *sourceName;
@property (nonatomic, retain, readwrite) NSString *title;
@property (nonatomic, retain, readwrite) UIImage *thumbnail;
@property (nonatomic, retain, readwrite) NSDate *publishDate;
@property (nonatomic, retain, readwrite) NSURL *url;
@property (nonatomic, retain, readwrite) FTHeadline *headline;
- (id)initWithHeadline:(FTHeadline *)headline;
@end