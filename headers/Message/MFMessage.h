@interface MFMessage : NSObject
- (NSString *)senderAddressComment;
- (NSString *)summary;
- (NSURL *)messageURL;
- (NSString *)messageBody;
- (NSDate *)dateReceived;
- (NSString *)messageIDHeader;
@end