//
//  CityWeatherViewController.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityWeatherViewController.h"

#import "Weather.h"

@interface CityWeatherViewController ()

@property (weak, nonatomic) IBOutlet UILabel *cityDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherIcon;
@property (weak, nonatomic) IBOutlet UILabel *weatherSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTempLabel;

@end

@implementation CityWeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    Weather *item = self.cityDetails;
//    
//
//    cell.cityLabel.text = item.weatherCity;
//    cell.tempLabel.text = item.weatherTemp;
//
//
//    self.cityDetailLabel.text = self.cityDetails;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
