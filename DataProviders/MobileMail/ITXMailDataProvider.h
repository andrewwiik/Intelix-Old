#import <Mail/MessageMiniMall.h>
#import <Mail/SharedMailboxController.h>
#import <Mail/MailboxSource.h>
#import <Mail/MFMailboxUid.h>
#import <Message/MFUserAgent-Protocol.h>
#import <Message/MailAccount.h>

#import "ITXMailMessage.h"

@interface ITXMailDataProvider : NSObject <MFUserAgent>
@property (nonatomic, assign, readwrite) BOOL isFetchingAccounts;
@property (nonatomic, retain, readwrite) MessageMiniMall *messageProvider;
@property (nonatomic, retain, readwrite) NSMutableArray<ITXMailMessage *> *messages;
@property (nonatomic, retain, readwrite) NSSet<MailAccount *> *displayedAccounts;
+ (instancetype)sharedInstance;
- (BOOL)canRegisterForAPSPush;
- (BOOL)isAllowedToAccessProtectedData;
- (BOOL)isMobileMail;
- (BOOL)isForeground;
- (void)networkActivityEnded:(id)ended;
- (void)networkActivityStarted:(id)started;
- (void)autofetchAccount:(id)account mailboxUid:(id)uid;
- (id)focusedMessage;
- (NSSet<MailAccount *> *)displayedAccounts;
- (NSUInteger)protectedDataAvailability;
- (void)updateData;
- (void)reloadAccounts;
- (void)reloadMessageProvider;
@end