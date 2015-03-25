//
//  CityWeatherViewController.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/20/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CityWeatherViewController.h"

@import MapKit;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344


@interface CityWeatherViewController ()

//@property (weak, nonatomic) IBOutlet UILabel *cityName;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *weatherSummaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *precepProbabilityLabel;
@property (weak, nonatomic) IBOutlet UILabel *windSpeedLabel;
@property (weak, nonatomic) IBOutlet UILabel *humidityLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation CityWeatherViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.backBarButtonItem.tintColor = [UIColor colorWithRed:192 green:161 blue:255 alpha:1];
    self.title = self.aCity.name;
 //    self.cityName.text = self.aCity.name;
    self.weatherSummaryLabel.text = self.aCity.currentWeather.summary;
    self.tempLabel.text = [self.aCity.currentWeather currentTemperature];
    self.apparentTempLabel.text = [self.aCity.currentWeather feelsLikeTemperature];
    self.precepProbabilityLabel.text = [self.aCity.currentWeather chanceOfRain];
    self.windSpeedLabel.text = [self.aCity.currentWeather windSpeedMPH];
    self.humidityLabel.text = [self.aCity.currentWeather humidityPercentage];
    self.iconImage.image = [UIImage imageNamed:[self.aCity.currentWeather icon]];
    
    [self configureMapView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.aCity coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion]; //where the map goes
    [self.mapView addAnnotation:self.aCity];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[City class]])
    {
        static NSString * const identifier = @"CityAnnotation";
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (annotationView)
        {
            annotationView.annotation = annotation;
        }
        else
        {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
    
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    return nil;
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
