#import "ITXMailDataProvider.h"


@implementation ITXMailDataProvider

+ (ITXMailDataProvider *)sharedInstance {
	static ITXMailDataProvider *_sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[ITXMailDataProvider alloc] init];
    });
    return _sharedInstance;
}

- (id)init {
	self = [super init];
	if (self) {

	}
	return self;
}

- (BOOL)canRegisterForAPSPush {
	return NO;
}
- (BOOL)isAllowedToAccessProtectedData {
	return YES;
}
- (BOOL)isMobileMail {
	return NO;
}
- (BOOL)isForeground {
	return NO;
}
- (void)networkActivityEnded:(id)ended {
	return;
}
- (void)networkActivityStarted:(id)started {
	return;
}
- (void)autofetchAccount:(id)account mailboxUid:(id)uid {
	// Method method = class_getInstanceMethod(NSClassFromString(@"MailAppController"), @selector(autofetchAccount:mailboxUid:));
	// IMP imp = method_getImplementation(method);
	// ((void (*)(id, SEL, id, id))imp)(self, @selector(autofetchAccount:mailboxUid:), account, uid);
}

- (id)focusedMessage {
	return nil;
}

- (NSSet<MailAccount *> *)displayedAccounts {
	if (!_displayedAccounts) {
		[self reloadAccounts];
	}
	return _displayedAccounts;
}

- (NSUInteger)protectedDataAvailability {
	return 0;
}

- (void)updateData {
	if (!_messageProvider) {
		[self reloadMessageProvider];
	}

	if (_messageProvider) {
		[_messageProvider _loadMessages];
	}
}

- (void)reloadAccounts {
	_displayedAccounts = nil;
	_isFetchingAccounts = YES;
	if (![NSClassFromString(@"MailAccount") mailAccounts] || [NSClassFromString(@"MailAccount") mailAccounts].count < 1) {
		[NSClassFromString(@"MailAccount") initialize];
		[NSClassFromString(@"MailAccount") reloadAccounts];
	}

	NSMutableArray *validAccounts = [NSMutableArray new];
	NSArray<MailAccount *> *accounts = [NSClassFromString(@"MailAccount") mailAccounts];
	for (MailAccount *account in accounts) {
		if ([account primaryMailboxUid]) {
			[validAccounts addObject:account];
		}
	}
	_isFetchingAccounts = NO;
	_displayedAccounts = [NSSet setWithArray:[validAccounts copy]];
}

- (void)reloadMessageProvider {

	if (!_displayedAccounts) {
		[self reloadAccounts];
	}

	_messageProvider = nil;
	MessageMiniMall *miniMall = [[NSClassFromString(@"MessageMiniMall") alloc] initWithObserver:nil tag:3];
	SharedMailboxController *controller = [NSClassFromString(@"SharedMailboxController") sharedInstanceForSourceType:3];
	NSArray<MFMailboxUid *> *mailboxes = (NSArray<MFMailboxUid *> *)[controller valueForKey:@"_mailboxes"];
	NSMutableArray *sources = [NSMutableArray new];
	for (MFMailboxUid *box in mailboxes) {
		MailboxSource *source = [[NSClassFromString(@"MailboxSource") alloc] initWithMailbox:box];
		if (source) {
			[miniMall addSource:source];
			[sources addObject:source];
		}
	}
	if (sources.count > 0) {
		_messageProvider = miniMall;
		[_messageProvider setComparator:^NSComparisonResult(id obj1, id obj2) {
			unsigned n1 = ((MFMailMessage *)obj1).dateReceivedInterval;
			unsigned n2 = ((MFMailMessage *)obj2).dateReceivedInterval;

			if (n1 > n2) return NSOrderedAscending;
	        else if (n1 < n2) return NSOrderedDescending;
	       	else return NSOrderedSame;
	      
		}];
	}
}

- (NSMutableArray<ITXMailMessage *> *)messages {
	if (!_messageProvider) [self reloadMessageProvider];
	if (!_messages && _messageProvider) {
		_messages = [NSMutableArray new];

	}
	return _messages;
}

- (ITXMailMessage *)messageForIndex:(NSUInteger)index {
	if (!_messageProvider) {
		[self reloadMessageProvider];
	}

	if (_messageProvider) {
		return [[ITXMailMessage alloc] initWithLibraryMessage:[_messageProvider messageAtTableIndexPath:[NSIndexPath indexPathForRow:index inSection:0]]];
	} else return nil;
}
@end