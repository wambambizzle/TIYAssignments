//
//  ViewController.h
//  Age Calculator
//
//  Created by Jordan Anderson on 3/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerBdayPickerDelegate // names and call the protocol

- (void) birthdayDateWasChoosen:(NSDate *) birthdayDate;

@end

@interface ViewController : UIViewController <ViewControllerBdayPickerDelegate> // the protocols name and calling it


@end

