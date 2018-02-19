@interface MailAccount : NSObject
+ (NSArray<MailAccount *> *)mailAccounts;
+ (void)initialize;
+ (void)reloadAccounts;
- (id)primaryMailboxUid;
@end