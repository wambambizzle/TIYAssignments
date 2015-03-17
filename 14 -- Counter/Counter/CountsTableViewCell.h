//
//  CountsTableViewCell.h
//  Counter
//
//  Created by Jordan Anderson on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *countDescriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;


@end
