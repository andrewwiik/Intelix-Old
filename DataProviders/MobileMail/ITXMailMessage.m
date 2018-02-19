#import "ITXMailMessage.h"

@implementation ITXMailMessage

- (id)initWithLibraryMessage:(MFLibraryMessage *)message {
	self = [super init];
	if (self) {
		if (message) {
			_message = message;
			_isRead = [message read];
			_sender = [message senderAddressComment];
			_subject = [message subjectNotIncludingReAndFwdPrefix];
			_summary = [message summary];
			if (!_summary) {
				[message _forceLoadOfMessageSummaryFromProtectedStore];
				_summary = [message summary];
			}
			_recievedDate = [message dateReceived];
			_url = [NSURL URLWithString:[NSString stringWithFormat:@"message://%@", [message messageIDHeader]]];
		} else return nil;
	}
	return self;
}
@end