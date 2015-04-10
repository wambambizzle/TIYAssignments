//
//  SearchResultsViewController.m
//  VenueMenu
//
//  Created by Jordan Anderson on 4/3/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "SearchResultsViewController.h"
#import "VenueMenuTableViewController.h"

#import "Venue.h"
#import "Location.h"

#import "MapObject.h"

@import MapKit;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344

@interface SearchResultsViewController () <MKAnnotation>
{
    double lat;
    double lng;
}

@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *streetAddy;
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *zipCode;
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
    
    self.name.text = [self.aVenue objectForKey:@"name"];
    
    NSDictionary *location = [self.aVenue objectForKey:@"location"];
    self.city.text = [location objectForKey:@"city"];
    
    self.state.text = [location objectForKey:@"state"];
    
    self.zipCode.text = [location objectForKey:@"postalCode"];
    
    NSArray *addy = [location objectForKey:@"formattedAddress"];
    self.streetAddy.text = [addy objectAtIndex:0];

    NSArray *categories = [self.aVenue objectForKey:@"categories"];
    NSDictionary *aCategory = [categories objectAtIndex:0];
    self.category.text = [aCategory objectForKey:@"name"];
    
    NSDictionary *contact = [self.aVenue objectForKey:@"contact"];
    self.phoneNumber.text = [contact objectForKey:@"formattedPhone"];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void)configureMapView
{
    NSDictionary *location = [self.aVenue objectForKey:@"location"];
     lat = [[location objectForKey:@"lat"] doubleValue];
     lng = [[location objectForKey:@"lng"] doubleValue];
    
     NSString *name = [self.aVenue objectForKey:@"name"];
    
    self.coordinate = CLLocationCoordinate2DMake(lat, lng);
    
    MapObject *mapObject = [[MapObject alloc] initWithCoordinate:self.coordinate userPinDescription:name];
    
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.coordinate, MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion]; //where the map goes
    [self.mapView addAnnotation:mapObject];
}

- (IBAction)addFavVenueButton:(UIButton *)sender
{
    Venue *aVenue = [NSEntityDescription insertNewObjectForEntityForName:@"Venue" inManagedObjectContext:self.cdStack.managedObjectContext]; // using core data / database to create a student object for us
    NSDictionary *location = [self.aVenue objectForKey:@"location"];
    lat = [[location objectForKey:@"lat"] doubleValue];
    lng = [[location objectForKey:@"lng"] doubleValue];
    
    aVenue.name = self.name.text;
    aVenue.category = self.category.text;
    aVenue.streeAddress = self.streetAddy.text;
    aVenue.city = self.city.text;
    aVenue.state = self.state.text;

    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    aVenue.postalCode =  [f numberFromString:[location objectForKey:@"postalCode"]];
    aVenue.location.latValue = lat;
    aVenue.location.lngValue = lng;
    
    [self saveCoreDataUpdates];
    
 [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
         }
     }];
    
}





@end
