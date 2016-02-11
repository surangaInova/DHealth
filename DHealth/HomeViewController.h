//
//  HomeViewController.h
//  DHealth
//
//  Created by inovaitsys on 2/2/16.
//  Copyright © 2016 INOVA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *profileView;

@end
