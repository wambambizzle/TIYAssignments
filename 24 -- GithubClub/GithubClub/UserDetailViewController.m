//
//  UserDetailViewController.m
//  GithubClub
//
//  Created by Jordan Anderson on 4/21/15.
//  Copyright (c) 2015 tiy. All rights reserved.
//

#import "UserDetailViewController.h"

@interface UserDetailViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *avatarImg;
@property (strong, nonatomic) IBOutlet UILabel *realName;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *reposNumb;
@property (strong, nonatomic) IBOutlet UILabel *following;
@property (strong, nonatomic) IBOutlet UILabel *follwers;
@property (strong, nonatomic) IBOutlet UILabel *location;
@property (strong, nonatomic) IBOutlet UILabel *emailAddy;
@property (strong, nonatomic) IBOutlet UILabel *hireable;

@end

@implementation UserDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

   self.realName.text = [self.userDetails objectForKey:@"name"];
    
    self.userName.text = [self.userDetails objectForKey:@"login"];
    NSURL *avatarURL = [NSURL URLWithString:[self.userDetails objectForKey:@"avatar_url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:avatarURL];
    UIImage *image = [UIImage imageWithData:imageData];
    self.avatarImg.image = image;
    
    double reposNumb = [[self.userDetails objectForKey:@"public_repos"] doubleValue];
    self.reposNumb.text = [NSString stringWithFormat:@"Repos: %0.0f", reposNumb];
    
    double followingNumb = [[self.userDetails objectForKey:@"fowllowing"] doubleValue];
    self.following.text = [NSString stringWithFormat:@"Following: %0.0f", followingNumb];
    
    double followersNumb = [[self.userDetails objectForKey:@"followers"] doubleValue];
    self.follwers.text = [NSString stringWithFormat:@"Followers: %0.0f", followersNumb];
    
    self.location.text = [self.userDetails objectForKey:@"location"];
    
    self.emailAddy.text = [self.userDetails objectForKey:@"email"];
    
    BOOL hireBool = [self.userDetails objectForKey:@"hireable"];
    self.hireable.text = [NSString stringWithFormat: @"Hireable: %@",(hireBool ? @"Looking For Work" : @"Not Looking for Work")];


}

- (void)didReceiveMemoryWarning
{
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
