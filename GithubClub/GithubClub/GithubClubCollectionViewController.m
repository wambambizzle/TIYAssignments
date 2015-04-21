//
//  GithubClubCollectionViewController.m
//  GithubClub
//
//  Created by Jordan Anderson on 4/20/15.
//  Copyright (c) 2015 tiy. All rights reserved.
//

#import "GithubClubCollectionViewController.h"
#import "NewClubMemberViewController.h"
#import "HubCollectionViewCell.h"
#import "UserDetailViewController.h"


@interface GithubClubCollectionViewController () <UITextFieldDelegate>
{
    NSMutableArray *_friends;
}


@end

@implementation GithubClubCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
//     self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    _friends = [[NSMutableArray alloc] init];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.collectionView reloadData];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _friends.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HubCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *friendInfo = _friends[indexPath.row];
//    NSLog(@"%@",friendInfo);

    cell.realName.text = [friendInfo objectForKey:@"name"];

    cell.userName.text = [friendInfo objectForKey:@"login"];
    NSURL *avatarURL = [NSURL URLWithString:[friendInfo objectForKey:@"avatar_url"]];
    NSData *imageData = [NSData dataWithContentsOfURL:avatarURL];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.avatarImg.image = image;
    
    double reposNumb = [[friendInfo objectForKey:@"public_repos"] doubleValue];
    cell.reposNumb.text = [NSString stringWithFormat:@"Repos: %0.0f", reposNumb];
    
    double followingNumb = [[friendInfo objectForKey:@"fowllowing"] doubleValue];
    cell.following.text = [NSString stringWithFormat:@"Following: %0.0f", followingNumb];
    
    double followersNumb = [[friendInfo objectForKey:@"followers"] doubleValue];
    cell.follwers.text = [NSString stringWithFormat:@"Followers: %0.0f", followersNumb];
    
    
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


//// Uncomment this method to specify if the specified item should be highlighted during tracking
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath 
// {
//	return YES;
//}



// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath 
 {
    return YES;
}



//// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath 
//{
//	return NO;
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender 
//{
//	return NO;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender 
//{
//	
//}


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowAddNewClub"])
    {
        UINavigationController *navC = [segue destinationViewController];
         NewClubMemberViewController *newClubVC = [navC viewControllers][0];
        newClubVC.friends = _friends;
    }
    else if ([segue.identifier isEqualToString:@"ShowDetailSegue"])
    {
        UserDetailViewController *userDetailVC = (UserDetailViewController *)[segue destinationViewController];
        HubCollectionViewCell *senderCell = (HubCollectionViewCell *)sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:senderCell];
        NSDictionary *aHub = _friends[indexPath.row];

        userDetailVC.userDetails = aHub;
        NSLog(@"userdetails: %@", userDetailVC.userDetails);
        
    }
    
}


@end
