//
//  BirthdayPickerViewController.h
//  Age Calculator
//
//  Created by Jordan Anderson on 3/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//
#import "UIKit/UIKit.h"
#import "ViewController.h"


@interface BirthdayPickerViewController : UIViewController

@property (strong, nonatomic) id<ViewControllerBdayPickerDelegate> delegate;



@end
