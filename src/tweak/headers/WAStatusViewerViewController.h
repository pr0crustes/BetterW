#import "WAStatusItem.h"
#import "WAActionSheetPresenter.h"

@interface WAStatusViewerViewController : UIViewController
	// Handler called to go to the next Status Item, after timer.
    -(void)statusViewerSectionViewDidFinishPresentingItem:(id)arg1;
	// Called to add all actions buttons to the WAActionSheetPresenter.
    -(void)addButtonsToActionSheet:(WAActionSheetPresenter *)actionSheet forIncomingStatusMessage:(id)arg2;
	// WAStatusItem getter.
	-(WAStatusItem *)currentStatusItem;

	// New
	-(void)pr0crustes_saveStatus;
@end
