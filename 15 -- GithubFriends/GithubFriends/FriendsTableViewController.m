//
//  FriendsTableViewController.m
//  GithubFriends
//
//  Created by Jordan Anderson on 3/18/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "FriendsTableViewController.h"

#import "FriendDetailViewController.h"
#import "NewFriendViewController.h"

#import "FriendCell.h"

@interface FriendsTableViewController ()
{
    NSMutableArray *friends;
}

@end

@implementation FriendsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    friends = [[NSMutableArray alloc] init];
    [self.tableView registerClass:[FriendCell class] forCellReuseIdentifier:@"FriendCell"];
    
    UIBarButtonItem *addFriendButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addFriend)];
    
    self.navigationItem.rightBarButtonItem = addFriendButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [friends count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell" forIndexPath:indexPath];
   
    NSDictionary *friendInfo = friends[indexPath.row];
    cell.textLabel.text = [friendInfo objectForKey:@"name"]; // or friendInfo[@"name"];
    NSURL *avatarURL = [NSURL URLWithString:[friendInfo objectForKey:@"avatar_url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:avatarURL];
    UIImage *image = [UIImage imageWithData:imageData];
     cell.imageView.image = image;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *aFriend = [friends objectAtIndex:indexPath.row];
    FriendDetailViewController *friendDetailVC = [[FriendDetailViewController alloc] init];
    friendDetailVC.friendInfo = aFriend;
    [self.navigationController pushViewController:friendDetailVC animated:YES];
}

#pragma mark - Action Handlers

- (void) addFriend
{
   NewFriendViewController *newFriendVC = [[NewFriendViewController alloc] init];
   UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:newFriendVC];
   newFriendVC.view.backgroundColor = [UIColor purpleColor];
   newFriendVC.friends = friends;
   
   [self presentViewController:navController animated:YES completion:nil];
    
}




















@end
