//
//  PopUpCalculationsTableViewController.h
//  High Voltage
//
//  Created by Jordan Anderson on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HighVoltageTableViewController.h"
#import "PowerCalculator.h"


@interface PopUpCalculationsTableViewController : UITableViewController
@property (strong, nonatomic) id<PopUpCalculationsTableVCDelegate> delegate;

@property (strong, nonatomic) NSMutableArray *recieveAllEnergyTypes;



@end
