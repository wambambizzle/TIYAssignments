//
//  SearchResultsViewController.h
//  VenueMenu
//
//  Created by Jordan Anderson on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreDataStack.h"


@interface SearchResultsViewController : UIViewController

@property(strong, nonatomic) CoreDataStack *cdStack;


@property (strong, nonatomic) NSDictionary *aVenue;


@end
