@interface NCNotificationListSection : NSObject
-(id)initWithIdentifier:(NSString *)arg1 title:(NSString *)title;
@property (nonatomic,retain) NSString *title;
@property (nonatomic,readonly) NSString *identifier; 
- (void)setSectionDate:(NSDate *)date;
- (NSDate *)sectionDate;
@end

@interface NCNotificationListSection (Intelix)
@property (nonatomic, retain) NSString *otherSectionIdentifier;
@property (nonatomic, retain) UIImage *iconImage; 
- (NSInteger)count;
@end