@protocol MFUserAgent <NSObject>
@required
- (BOOL)canRegisterForAPSPush;
- (BOOL)isAllowedToAccessProtectedData;
- (BOOL)isMobileMail;
- (BOOL)isForeground;
- (void)networkActivityEnded:(id)ended;
- (void)networkActivityStarted:(id)started;
- (void)autofetchAccount:(id)account mailboxUid:(id)uid;
- (id)focusedMessage;
@end