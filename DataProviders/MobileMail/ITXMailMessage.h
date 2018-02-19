
#import <Message/MFLibraryMessage.h>

@interface ITXMailMessage : NSObject
@property (nonatomic, assign, readwrite) BOOL isRead;
@property (nonatomic, retain, readwrite) NSString *sender;
@property (nonatomic, retain, readwrite) NSString *subject;
@property (nonatomic, retain, readwrite) NSString *summary;
@property (nonatomic, retain, readwrite) NSDate *recievedDate;
@property (nonatomic, retain, readwrite) MFMessage *message;
@property (nonatomic, retain, readwrite) NSURL *url;
- (id)initWithLibraryMessage:(MFLibraryMessage *)message;
@end