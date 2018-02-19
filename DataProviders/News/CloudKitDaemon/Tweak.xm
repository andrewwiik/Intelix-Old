%hook CKDClientProxy
- (BOOL)_hasEntitlementForKey:(id)key {
	return YES;
}
%end

%ctor {
	%init;
}