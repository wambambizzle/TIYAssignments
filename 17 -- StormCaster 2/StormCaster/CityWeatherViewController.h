//
//  CityWeatherViewController.h
//  StormCaster
//
//  Created by Jordan Anderson on 3/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "City.h"

#import "StormCasterTableViewController.h"

@interface CityWeatherViewController : UIViewController

@property (nonatomic, strong) City *aCity;

@end
