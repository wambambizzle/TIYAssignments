//
//  HubCollectionViewCell.h
//  GithubClub
//
//  Created by Jordan Anderson on 4/20/15.
//  Copyright (c) 2015 tiy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HubCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UIImageView *avatarImg;
@property (strong, nonatomic) IBOutlet UILabel *realName;
@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *reposNumb;
@property (strong, nonatomic) IBOutlet UILabel *following;
@property (strong, nonatomic) IBOutlet UILabel *follwers;


@end
