//
//  ViewController.h
//  CoreList
//
//  Created by Jordan Anderson on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListItem.h"

#import "CoreDataStack.h"

@interface ViewController : UIViewController

@property(strong, nonatomic) CoreDataStack *cdStack;

@end

