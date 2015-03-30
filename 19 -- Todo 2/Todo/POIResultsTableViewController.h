//
//  POIResultsTableViewController.h
//  Todo
//
//  Created by Jordan Anderson on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoItem.h"

@interface POIResultsTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *locationsArray;
@property (nonatomic, strong) TodoItem *aTask;

@end
