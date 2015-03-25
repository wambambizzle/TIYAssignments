//
//  StormCasterTableViewController.h
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "City.h"


@protocol CitiesTableViewControllerDelegate 

-(void)cityWasFound:(City *)aCity;
-(void)weatherWasFoundForCity:(City *)aCity;

@end

@interface StormCasterTableViewController : UITableViewController <CitiesTableViewControllerDelegate>

- (void)saveCityData;

@end
