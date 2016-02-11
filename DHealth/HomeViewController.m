//
//  HomeViewController.m
//  DHealth
//
//  Created by inovaitsys on 2/2/16.
//  Copyright © 2016 INOVA. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:@"https://pixabay.com/static/uploads/photo/2014/12/23/14/45/woman-578429_960_720.jpg"];
    self.profileView.layer.cornerRadius = (self.profileView.frame.size.width / 2)-3;
    self.profileView.clipsToBounds = YES;
    self.profileView.layer.borderWidth = 3.0f;
    self.profileView.layer.borderColor = [UIColor whiteColor].CGColor;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.profileView.image = image;
        });
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
