#import "WAStatusItem.h"
#import "WAActionSheetPresenter.h"

@interface WAStatusViewerViewController : UIViewController
    -(void)statusViewerSectionViewDidFinishPresentingItem:(id)arg1;
    -(void)addButtonsToActionSheet:(WAActionSheetPresenter *)actionSheet forIncomingStatusMessage:(id)arg2;
	-(WAStatusItem*)currentStatusItem;

	// New
	-(void)pr0crustes_saveStatus;
@end
