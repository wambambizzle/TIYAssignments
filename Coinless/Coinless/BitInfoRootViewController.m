//
//  BitInfoRootViewController.m
//  Coinless
//
//  Created by Jordan Anderson on 4/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "BitInfoRootViewController.h"

@interface BitInfoRootViewController ()

@end

@implementation BitInfoRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Bitcoin Basics";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

-(IBAction)bitInfoHideModal:(id)sender
{
    [self cancel];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
