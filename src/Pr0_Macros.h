#define MACRO_present_alert_with(handlerYes, handlerNo) \
{ \
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to call?" preferredStyle:UIAlertControllerStyleAlert]; \
    UIAlertAction* yesAction = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { handlerYes; }]; \
    UIAlertAction* noAction = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {handlerNo; }]; \
    [alert addAction:yesAction]; \
    [alert addAction:noAction]; \
    [self presentViewController:alert animated:YES completion:nil]; \
}
