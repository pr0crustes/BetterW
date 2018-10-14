// // #import "headers/.h"

// #import "_Pr0_Utils.h"


// @interface _WATableViewCellWithFakeButton : UITableViewCell
// 	-(id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2;
// @end


// @interface WATableRow : NSObject {
//     UITableViewCell *_cell;
// }

// 	@property(readonly, nonatomic) UITableViewCell *cell;

// 	-(id)initWithCell:(UITableViewCell *)arg1;
// @end


// @interface WATableSection : NSObject
// 	-(void)insertRow:(WATableRow *)arg1 atIndex:(long long)arg2;
// @end


// @interface WASinglePersonPicker : UITableViewController {
// 	WATableSection *_sectionTopActions;
// }

// 	-(void)viewWillAppear:(_Bool)arg1;
// 	-(void)tableView:(id)table didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
// 	-(_Bool)tableView:(id)table isActionsSection:(long long)indexPathSection;

// 	// New
// 	-(void)pr0crustes_askForNumber;
// 	-(void)pr0crustes_chatWithNumber:(NSString *)number;
// @end



// %group GROUP_NEW_NUMBER_CHAT

// 	%hook WASinglePersonPicker

// 		-(void)viewWillAppear:(_Bool)arg1 {
// 			%orig;

// 			_WATableViewCellWithFakeButton* cell = [%c(_WATableViewCellWithFakeButton) alloc];
// 			cell = [cell initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
// 			cell.textLabel.text =  @"Chat With Number";
// 			cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:0.486 blue:1.0 alpha:1.0];

// 			WATableRow* tableRow = [[%c(WATableRow) alloc] initWithCell:cell];

// 			WATableSection *sectionTop = MSHookIvar<WATableSection *>(self, "_sectionTopActions");
// 			[sectionTop insertRow:tableRow atIndex:2];
// 		}

// 		-(void)tableView:(id)arg1 didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
// 			if ([self tableView:arg1 isActionsSection:indexPath.section]) {  // Is action
// 				if (indexPath.row == 2) {  // Is the new button
// 					return [self pr0crustes_askForNumber];
// 				}
// 			}
// 			return %orig;
// 		}

// 		%new
// 		-(void)pr0crustes_askForNumber {
// 			UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"Number" message: @"Enter the target phone number:" preferredStyle:UIAlertControllerStyleAlert];
			
// 			[alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
// 				textField.placeholder = @"+12025550158";
// 				textField.textColor = [UIColor blueColor];
// 				textField.clearButtonMode = UITextFieldViewModeWhileEditing;
// 				textField.borderStyle = UITextBorderStyleRoundedRect;
// 			}];

// 			UIAlertAction* startAction = [UIAlertAction actionWithTitle:@"Start Chat" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
// 				UITextField* phoneField = alertController.textFields[0];
// 				NSLog(@"%@", phoneField.text);
// 			}];
// 			[alertController addAction:startAction];

// 			UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil];
// 			[alertController addAction:cancelAction];

// 			[self presentViewController:alertController animated:YES completion:nil];
// 		}

// 	%end

// %end



// %ctor {

// 	if (/*FUNCTION_prefGetBool(@"")*/ true) {
// 		FUNCTION_logEnabling(@"New Number Chat");
// 		%init(GROUP_NEW_NUMBER_CHAT);
// 	}

// }
