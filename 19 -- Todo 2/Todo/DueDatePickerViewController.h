//
//  DueDatePickerViewController.h
//  Todo
//
//  Created by Jordan Anderson on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoDetailTableViewController.h"


@interface DueDatePickerViewController : UIViewController

@property(strong, nonatomic) id<DueDatePickerDelegate>delegate;

@property (nonatomic, strong) NSDate *selectedDueDate;

@end
