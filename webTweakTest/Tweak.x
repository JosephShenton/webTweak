%hook SpringBoard


// Attempt to display ad after respring
-(void)applicationDidFinishLaunching:(id)application {
    %orig;
    
	// Select current view controller to display ad. 
	/*
		This part may not work, I am writing this code without testing it as I cannot currently jailbreak my iPhone
		due to me not having my port adapter.
	*/
    UIViewController * controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (controller.presentedViewController) {
        controller = controller.presentedViewController;
    }
	
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"WooHoo" message:@"WebTweak Worked!" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* onAction = [UIAlertAction actionWithTitle:@"Cool" style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction * action) {
                                                      
                                                 }];

    UIAlertAction* offAction = [UIAlertAction actionWithTitle:@"Great" style:UIAlertActionStyleDefault
                                                  handler:^(UIAlertAction * action) {
                                                      
                                                  }];
    [alert addAction:offAction];
    [alert addAction:onAction];
    [controller presentViewController:alert animated:YES completion:nil];
}

%end