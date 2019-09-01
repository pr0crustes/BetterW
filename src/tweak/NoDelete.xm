#import "headers/WAChatStorage.h"
#import "headers/WAMessage.h"

#import "_Pr0_Utils.h"


%group GROUP_NO_DELETE

	%hook WAChatStorage

		- (void)revokeIncomingMessage:(WAMessage *)message updatedStanzaID:(id)arg2 outOfOrder:(_Bool)arg3 revokeDate:(NSDate *)date deferAction:(id)arg5 {
			NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
			[dateFormatter setLocale:[NSLocale currentLocale]];
			[dateFormatter setDateFormat:@"dd-MM-YYYY HH:mm:ss"];
			NSString *formattedDate = date ? [dateFormatter stringFromDate:date] : @"Unable to determine date.";
			[message setText:[NSString stringWithFormat:@"◉【 Deleted Message 】◉\n◉【 %@ 】◉\n\n %@", formattedDate, [message text]]];
			return;
		}

	%end

%end



%ctor {

	if (F_prefGetBool(@"pref_no_delete")) {
		F_logEnabling(@"No Delete");
		%init(GROUP_NO_DELETE);
	}

}

