//
//  ViewController.m
//  DropIt
//
//  Created by Jordan Anderson on 3/25/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"

#import "PinDrop.h"

#define kPinKey @"pin"

@import CoreLocation; // coordinates
@import MapKit;
//@import AddressBook;

#define MAP_DISPLAY_SCALE 0.5 * 1609.344

@interface ViewController () <CLLocationManagerDelegate, UITextFieldDelegate>
{
    CLLocationManager *locationManager;

}
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;

@property (strong, nonatomic) PinDrop *currentLocation;

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addPinButton;

- (IBAction)addNewPinButton:(UIBarButtonItem *)sender;


- (IBAction)clearPinsButton:(UIBarButtonItem *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self loadPinData];
    
    self.navigationItem.prompt = @"Enter a description and drop a pin at your car!";
    
    if (!self.currentLocation)
    {
        [self configureLocationManager];
    }
    else
    {
        [self configureMapView];
        [self addAnnotationMap];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Load and Save data

- (void)loadPinData
{
    NSData *pinData = [[NSUserDefaults standardUserDefaults] objectForKey:kPinKey];
    if (pinData)
    {
         self.currentLocation = [NSKeyedUnarchiver unarchiveObjectWithData:pinData];
    }
    else
    {
         self.currentLocation = nil;
    }
}

- (void)savePinData
{
    NSData *pinData = [NSKeyedArchiver archivedDataWithRootObject:self.currentLocation];
    [[NSUserDefaults standardUserDefaults] setObject:pinData forKey:kPinKey];
}


#pragma mark - Action Handlers

- (IBAction)addNewPinButton:(UIBarButtonItem *)sender
{
    if (![self.titleTextField.text  isEqualToString:@""])
    {
        [self addAnnotationMap];
        self.currentLocation.name = self.titleTextField.text;
        
        [self.titleTextField resignFirstResponder];
        self.titleTextField.text = @"";

    }
}

- (IBAction)clearPinsButton:(UIBarButtonItem *)sender
{
    [self.mapView removeAnnotation:self.currentLocation];
    self.currentLocation = nil;
    
//    [self configureLocationManager];
}

#pragma mark - Configure map view

- (void)configureMapView
{
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.currentLocation coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
    [self.mapView setRegion:viewRegion]; //where the map goes
    
}

- (void)addAnnotationMap
{
    [self.mapView addAnnotation:self.currentLocation]; //add the Pin to the Map
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[PinDrop class]])
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



#pragma mark - CLLocation related methods

- (void)configureLocationManager
{
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted)
    {
        if (!locationManager)
        {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
            if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
            {
                [locationManager requestWhenInUseAuthorization];
            }
            else
            {
                [self enableLocationManager:YES];
            }
        }
    }
    else
    {
//        [self.addPinButton setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
//        [self.addPinButton setEnabled:NO];
    }
    else
    {
        [self enableLocationManager:YES];
    }
}

-(void)enableLocationManager:(BOOL)enable
{
    if (locationManager)
    {
        if (enable)
        {
            [locationManager stopUpdatingLocation];
            [locationManager startUpdatingLocation];
        }
        else
        {
            [locationManager stopUpdatingLocation];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error != kCLErrorLocationUnknown)
    {
        [self enableLocationManager:NO];
//      [self.addPinButton setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [self enableLocationManager:NO];
    self.currentLocation = [[PinDrop alloc] initWithCoordinate:location.coordinate name:self.titleTextField.text];

    [self configureMapView];

}


#pragma mark - UITextField delegate w/ Validation

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if ([textField.text isEqualToString:@""])
    {
        
        [textField becomeFirstResponder];
        rc = NO;
    }
    else if (![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        rc = YES;
    }
    
    return rc;
}



@end
