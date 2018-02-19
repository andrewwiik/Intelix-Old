#import <objc/runtime.h>
#import <dlfcn.h>
#include <substrate.h>

#import "ITXMailDataProvider.h"


%hook SpringBoard
%new
- (id)displayedAccounts {
	return [[ITXMailDataProvider sharedInstance] displayedAccounts];
}

%new
- (NSUInteger)protectedDataAvailability {
	return [[ITXMailDataProvider sharedInstance] protectedDataAvailability];
}
%end


%hook MailXPCServices
-(BOOL)_connection:(id)connection hasEntitlement:(id)entitlement {
	return YES;
}
%end

%hook MailAccount
+ (void)reloadAccounts {
	[ITXMailDataProvider sharedInstance].isFetchingAccounts = YES;
	%orig;
	[ITXMailDataProvider sharedInstance].isFetchingAccounts = NO;
}
%end

%hook MFXPCClient
-(BOOL)hasEntitlement:(id)arg1 {
	return YES;
}
%end

#pragma mark Function Hooks

int (*orig_MFHasAccountsEntitlement)();
int MFHasAccountsEntitlement () {
	return 1;
}

id (*orig_MFUserAgent)();
id MFUserAgent () {
	if ([ITXMailDataProvider sharedInstance].isFetchingAccounts) return nil;
	else return [ITXMailDataProvider sharedInstance];
}

%ctor {
	dlopen("/System/Library/PrivateFrameworks/Message.framework/Message", RTLD_NOW);
	dlopen("/System/Library/PrivateFrameworks/MessageSupport.framework/MessageSupport", RTLD_NOW);
	dlopen("/Library/Intelix/DataProviders/ITXMobileMailProvider.bundle/ITXMobileMailService.framework/ITXMobileMailService", RTLD_NOW);
	
	MSHookFunction((void *)MSFindSymbol(NULL,"_MFHasAccountsEntitlement"), (void *)MFHasAccountsEntitlement, (void **)&orig_MFHasAccountsEntitlement);
	MSHookFunction((void *)MSFindSymbol(NULL,"_MFUserAgent"), (void *)MFUserAgent, (void **)&orig_MFUserAgent);
	%init;
}


