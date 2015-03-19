//
//  NewFriendViewController.m
//  GithubFriends
//
//  Created by Jordan Anderson on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "NewFriendViewController.h"

@interface NewFriendViewController ()
{
   UITextField *usernameTextField;
}

@end

@implementation NewFriendViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
   // create username text field
   usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 74, 300, 40)];
   usernameTextField.placeholder = @"Username";
   usernameTextField.backgroundColor = [UIColor whiteColor];
   usernameTextField.textAlignment = NSTextAlignmentCenter;
   
   [self.view addSubview:usernameTextField];  //add username textfield to the view
  
   // create Git User button
   
   CGFloat saveFriendY = usernameTextField.frame.origin.y + usernameTextField.frame.size.height + 10;
   UIButton *saveFriend = [[UIButton alloc] initWithFrame:CGRectMake(10, saveFriendY, 300, 40)];
   [saveFriend setTitle:@"Git User" forState:UIControlStateNormal];
   [saveFriend addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:saveFriend];
   
   //Create cancel button
   
   CGFloat cancelY = saveFriend.frame.origin.y + saveFriend.frame.size.height + 10;
   UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, cancelY, 300, 40)];
   [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
   [cancelButton addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:cancelButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)save
{
   NSString *username = usernameTextField.text;
   NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
   NSURL *url = [NSURL URLWithString:urlString];
   
   NSURLRequest *request = [NSURLRequest requestWithURL:url];
   
   NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
   
   NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
   
   [self.friends addObject:userInfo];
   
   [self cancel];
}

- (void)cancel
{
   [self dismissViewControllerAnimated:YES completion:nil];
}


@end
