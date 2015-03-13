//
//  HighVoltageTableViewController.h
//  High Voltage
//
//  Created by Jordan Anderson on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopUpCalculationsTableVCDelegate

- (void)engeryTypeWasSelected:(NSString *)energyStringSelected;

@end

@interface HighVoltageTableViewController : UITableViewController <PopUpCalculationsTableVCDelegate>



@end
