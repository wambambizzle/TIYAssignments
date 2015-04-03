//
//  SearchResultsTableViewController.h
//  VenueMenu
//
//  Created by Jordan Anderson on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreDataStack.h"

@interface SearchResultsTableViewController : UITableViewController

@property(strong, nonatomic) CoreDataStack *cdStack;

@end
