//
//  SearchResultsViewController.m
//  VenueMenu
//
//  Created by Jordan Anderson on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "SearchResultsViewController.h"

#import "MapObject.h"

#import "CoreDataStack.h"

@import MapKit;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344

@interface SearchResultsViewController () <MKAnnotation>
{
    
}

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *streetAddy;
@property (weak, nonatomic) IBOutlet UILabel *cityStateZip;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

- (IBAction)addFavVenueButton:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) CLLocationCoordinate2D coordinate;

@end

@implementation SearchResultsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureMapView];
    
    NSString *name = [self.aVenue objectForKey:@"name"];
    self.name.text = name;
    
    NSDictionary *location = [self.aVenue objectForKey:@"location"];
    NSArray *addy = [location objectForKey:@"formattedAddress"];
    NSString *streetAddress = [addy objectAtIndex:0];
    self.streetAddy.text = streetAddress;
    
    NSString *citySate = [addy objectAtIndex:1];
    self.cityStateZip.text = citySate;
    
    NSArray *categories = [self.aVenue objectForKey:@"categories"];
    NSDictionary *aCategory = [categories objectAtIndex:0];
    NSString *theCat = [aCategory objectForKey:@"name"];
    
    self.category.text = theCat;
    
    NSDictionary *contact = [self.aVenue objectForKey:@"contact"];
    NSString *phoneNumb = [contact objectForKey:@"formattedPhone"];
    
    self.phoneNumber.text = phoneNumb;
    
    
    
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

- (void)configureMapView
{
    NSDictionary *location = [self.aVenue objectForKey:@"location"];
    double lat = [[location objectForKey:@"lat"] doubleValue];
    double lng = [[location objectForKey:@"lng"] doubleValue];
    
     NSString *name = [self.aVenue objectForKey:@"name"];
    
    self.coordinate = CLLocationCoordinate2DMake(lat, lng);
    
    MapObject *mapObject = [[MapObject alloc] initWithCoordinate:self.coordinate userPinDescription:name];
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.coordinate, MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion]; //where the map goes
    [self.mapView addAnnotation:mapObject];
}



- (IBAction)addFavVenueButton:(UIButton *)sender
{
    
}
@end
