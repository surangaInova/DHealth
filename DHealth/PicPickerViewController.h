//
//  PicPickerViewController.h
//  DHealth
//
//  Created by inovaitsys on 2/2/16.
//  Copyright © 2016 INOVA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface PicPickerViewController :  UIViewController
<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIButton *retakePic;
@property (strong, nonatomic) IBOutlet UIButton *cameraButton;

@property (strong, nonatomic) IBOutlet UITextField *commentsText;
@property (nonatomic, retain) IBOutlet UIImageView *imageView;
- (IBAction)AddComment:(id)sender;



- (IBAction)useCamera;
//- (IBAction)useCameraRoll;
@end
