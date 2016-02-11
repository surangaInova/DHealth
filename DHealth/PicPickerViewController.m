//
//  PicPickerViewController.m
//  DHealth
//
//  Created by inovaitsys on 2/2/16.
//  Copyright © 2016 INOVA. All rights reserved.
//

#import "PicPickerViewController.h"
#define IS_IOS8 [[UIDevice currentDevice].systemVersion floatValue] >= 8.0

@interface PicPickerViewController ()
{
    BOOL newMedia;
    UITextField *activeField;
    UIAlertControllerStyle *myAlertView;
}
@end

@implementation PicPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerForKeyboardNotifications];
    self.commentsText.delegate= self;
    if(newMedia){
        [self.cameraButton setHidden:YES];
        [self.retakePic setHidden:NO];
    }else{
        [self.retakePic setHidden:YES];
    }
    
}

- (void)viewDidAppear:(BOOL)animated{
    if(newMedia){
        [self.cameraButton setHidden:YES];
        [self.retakePic setHidden:NO];
    }else{
        [self.retakePic setHidden:YES];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info
                          objectForKey:UIImagePickerControllerOriginalImage];
        
        _imageView.image = image;
        
        if (newMedia)
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        // Code here to support video if enabled
    }
}

-(void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
 contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
        
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)AddComment:(id)sender {
    [self generateOTPConfirm:@"" withTitle:@"" withView:self];

}

- (void) useCamera
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *imagePicker =
        [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        imagePicker.sourceType =
        UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                  (NSString *) kUTTypeImage,
                                  nil];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
        //[imagePicker release];
        newMedia = YES;
    }
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.imageView = nil;
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    [_scrollView setScrollEnabled:YES];
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height+100, 0.0);
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    //UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentOffset = CGPointMake(0,0); //wherever you want to scroll
    [_scrollView setScrollEnabled:NO];
}



- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    activeField = nil;
}

-(void) generateOTPConfirm:(NSString *) message withTitle:(NSString *) title withView:(UIViewController *) view{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"My Alert" message:@"This is an alert." preferredStyle:UIAlertControllerStyleActionSheet]; // 7
    
    UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        NSLog(@"You pressed button OK");
    }]; // 8
    
    [alert addAction:defaultAction]; // 9
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Input data...";
    }]; // 10
    
    [self presentViewController:alert animated:YES completion:nil]; // 11
//    if (IS_IOS8) {
//        __alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        __alertWindow.rootViewController = [UIViewController new];
//        __alertWindow.windowLevel = 10000001;
//        __alertWindow.hidden = NO;
//        __weak __typeof(self) weakSelf = self;
//        
//        alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *cancelAction = [UIAlertAction
//                                       actionWithTitle:NSLocalizedString(@"CONFIRM_CANCEL",nil)
//                                       style:UIAlertActionStyleDefault
//                                       handler:^(UIAlertAction *action)
//                                       {
//                                           weakSelf._alertWindow.hidden = YES;
//                                           weakSelf._alertWindow = nil;
//                                       }];
//        UIAlertAction *proceedAction = [UIAlertAction
//                                        actionWithTitle:NSLocalizedString(@"CONFIRM_OK",nil)
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction *action)
//                                        {
//                                            NSError *error;
//                                            NSMutableDictionary *nsdata = [[NSMutableDictionary alloc] init];
//                                            
//                                            NSMutableDictionary *deviceInfo = [[NSMutableDictionary alloc] init];
//                                            NSMutableDictionary *iddic = [[NSMutableDictionary alloc] init];
//                                            [iddic setObject:[AppSettings getInstance].MSISDN forKey:@"mobileNumber"];
//                                            NSString *UDID = [[[[UIDevice currentDevice] identifierForVendor] UUIDString] lowercaseString];
//                                            [iddic setObject:UDID forKey:@"imei"];
//                                            [deviceInfo setObject:iddic forKey:@"id"];
//                                            [nsdata setObject:deviceInfo forKey:@"deviceInfo"];
//                                            
//                                            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:nsdata options:NSJSONWritingPrettyPrinted error:&error];
//                                            NSString *stringData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//                                            myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"PROCESSING_LABLE", nil) message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
//                                            UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//                                            [indicator startAnimating];
//                                            [myAlertView setValue:indicator forKey:@"accessoryView"];
//                                            [myAlertView show];
//                                            
//                                            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:sBaseURL generateOTP]];
//                                            request.HTTPMethod = @"POST";
//                                            [request setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//                                            NSData *requestBodyData = [stringData dataUsingEncoding:NSUTF8StringEncoding];
//                                            request.HTTPBody = requestBodyData;
//                                            conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//                                            OTPgenerate = true;
//                                            [self.view endEditing:YES];
//                                            weakSelf._alertWindow.hidden = YES;
//                                            weakSelf._alertWindow = nil;
//                                            
//                                        }];
//        [alert addAction:cancelAction];
//        [alert addAction:proceedAction];
//        
//        [__alertWindow.rootViewController presentViewController:alert animated:YES completion:nil];
//        
//    }
//    else{
//        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:NSLocalizedString(@"CONFIRM_CANCEL",nil) otherButtonTitles:NSLocalizedString(@"CONFIRM_OK",nil), nil];
//        [alert2 show];
//    }
    
}

@end
