// #import <objc/runtime.h>
// #import <dlfcn.h>
// #include <substrate.h>

// #import "ITXMailDataProvider.h"


// %hook SpringBoard
// %new
// - (id)displayedAccounts {
// 	return [[ITXMailDataProvider sharedInstance] displayedAccounts];
// }

// %new
// - (NSUInteger)protectedDataAvailability {
// 	return [[ITXMailDataProvider sharedInstance] protectedDataAvailability];
// }
// %end


// %hook MailXPCServices
// -(BOOL)_connection:(id)connection hasEntitlement:(id)entitlement {
// 	return YES;
// }
// %end

// %hook MailAccount
// + (void)reloadAccounts {
// 	[ITXMailDataProvider sharedInstance].isFetchingAccounts = YES;
// 	%orig;
// 	[ITXMailDataProvider sharedInstance].isFetchingAccounts = NO;
// }
// %end

// %hook MFXPCClient
// -(BOOL)hasEntitlement:(id)arg1 {
// 	return YES;
// }
// %end

// #pragma mark Function Hooks

// int (*orig_MFHasAccountsEntitlement)();
// int MFHasAccountsEntitlement () {
// 	return 1;
// }

// id (*orig_MFUserAgent)();
// id MFUserAgent () {
// 	if ([ITXMailDataProvider sharedInstance].isFetchingAccounts) return nil;
// 	else return [ITXMailDataProvider sharedInstance];
// }

// com.apple.news.widget

// static BOOL shouldFakeToNews = NO;

// %hook NSBundle
// - (NSString *)bundleIdentifier {
// 	if (shouldFakeToNews) {
// 		NSString *identifier = %orig;
// 		if (identifier && [identifier isEqualToString:@"com.apple.springboard"]) {
// 			return [NSString stringWithFormat:@"com.apple.news.widget"];
// 		}
// 	}
// 	return %orig;
// }
// %end

%hook FCCKDirectRequestOperation
-(NSMutableDictionary *)_requestHeadersWithBaseURL:(id)arg1  {
	NSMutableDictionary *orig = %orig;
	[orig setObject:[NSString stringWithFormat:@"com.apple.news.widget"] forKeyedSubscript:@"X-CloudKit-BundleId"];
	return orig;
}
%end

// %hook CKPackage
// - (id)_packagesBasePathForBundleID:(id)identifier {
// 	if (identifier && [identifier isEqualToString:@"com.apple.springboard"]) {
// 		return %orig([NSString stringWithFormat:@"com.apple.news.widget"]);
// 	} else return %orig;
// }
// %end


// %hook PARSessionConfiguration
// + (NSString *)identifier {
// 	return [NSString stringWithFormat:@"com.apple.news.widget"];
// }
// %end


%hook CKContainer
+ (void)_checkSelfCloudServicesEntitlement {
	return;
}
+ (void)_checkSelfContainerIdentifier {
	return;
}
- (void)_checkSelfCloudServicesEntitlement {
	return;
}
- (void)_checkSelfContainerIdentifier {
	return;
}
%end

%hook FTHeadlineResultOperation
- (void)setHeadlinesLimit:(NSUInteger)limit {
	%orig(20);
}
- (NSUInteger)headlinesLimit {
	return 20;
}
%end

// %hook NSURLRequest
// + (id)overrideUserAgent {
// 	shouldFakeToNews = YES;
// 	id orig = %orig;
// 	shouldFakeToNews = NO;
// 	return orig;
// }
// %end


static int (*orig_BSXPCConnectionHasEntitlement)(id connection, NSString *entitlement);
static int hax_BSXPCConnectionHasEntitlement(__unsafe_unretained id connection, __unsafe_unretained NSString *entitlement) {
    if ([entitlement isEqualToString:@"com.apple.developer.icloud-services"]) {
        return true;
    }

    return orig_BSXPCConnectionHasEntitlement(connection, entitlement);
}


%ctor {
	// dlopen("/System/Library/PrivateFrameworks/Message.framework/Message", RTLD_NOW);
	// dlopen("/System/Library/PrivateFrameworks/MessageSupport.framework/MessageSupport", RTLD_NOW);
	dlopen("/Library/Intelix/DataProviders/ITXNewsProvider.bundle/ITXNewsService.framework/ITXNewsService", RTLD_NOW);
	void *xpcFunction = MSFindSymbol(NULL, "_BSXPCConnectionHasEntitlement");
    MSHookFunction(xpcFunction, (void *)hax_BSXPCConnectionHasEntitlement, (void **)&orig_BSXPCConnectionHasEntitlement);
	// MSHookFunction((void *)MSFindSymbol(NULL,"_MFHasAccountsEntitlement"), (void *)MFHasAccountsEntitlement, (void **)&orig_MFHasAccountsEntitlement);
	// MSHookFunction((void *)MSFindSymbol(NULL,"_MFUserAgent"), (void *)MFUserAgent, (void **)&orig_MFUserAgent);
	%init;
}


