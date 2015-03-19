//
//  FriendDetailViewController.m
//  GithubFriends
//
//  Created by Jordan Anderson on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FriendDetailViewController.h"

#import "FriendCell.h"


@interface FriendDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *repos;
    UILabel *userLocation;
    UILabel *userEmail;
    UITableView *userRepoTableView;
}

@end

@implementation FriendDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSString *login = [self.friendInfo objectForKey:@"login"];
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@/repos", login];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    repos = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
//    NSLog(@"%@", repos);
    
    // User Location
    
    userLocation = [[UILabel alloc] initWithFrame:CGRectMake(10, 74, 300, 40)];
    userLocation.text = [NSString stringWithFormat:@"%@", [self.friendInfo objectForKey:@"location"]];
    userLocation.textAlignment = NSTextAlignmentCenter;
    userLocation.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:userLocation];
    
    // User Email
    
    CGFloat userEmailY = userLocation.frame.origin.y + userLocation.frame.size.height + 10;
    userEmail = [[UILabel alloc] initWithFrame:CGRectMake(10, userEmailY, 300, 40)];
    userEmail.text = [NSString stringWithFormat:@"%@",[self.friendInfo objectForKey:@"email"]];
    userEmail.textAlignment = NSTextAlignmentCenter;
    userEmail.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:userEmail];
    
    // User Repo Table View
    
    CGFloat userRepoTableViewY = userEmail.frame.origin.y + userEmail.frame.size.height + 10;
    CGFloat userRepoTableViewWidth = self.view.frame.size.width; //- 10;
    CGFloat userRepoTableViewHeight = self.view.frame.size.height; //- 170;
    userRepoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, userRepoTableViewY,userRepoTableViewWidth ,userRepoTableViewHeight ) style:UITableViewStyleGrouped];
//   [userRepoTableView dequeueReusableCellWithIdentifier:@"RepoCell"];
    
    [self.view addSubview:userRepoTableView];
    
    // userRepoTableView.text =[NSString stringWithFormat:@"", [self.friendInfo objectForKey:@""]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [repos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RepoCell" forIndexPath:indexPath];
    
//    cell.reposLabel.delegate = self;
    
//    Count *item = counterList[indexPath.row];
    userRepoTableView.delegate = self;
    
    NSArray *aRepo = [repos valueForKey:@"name"];
    
    for (NSString *repoName in aRepo)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"%@", repoName];
        
    }

    return cell;
    
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
