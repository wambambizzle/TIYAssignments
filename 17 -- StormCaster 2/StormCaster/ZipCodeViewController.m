//
//  ZipCodeViewController.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ZipCodeViewController.h"

#import "City.h"
#import "NetworkManager.h"

@import CoreLocation; // coordinates
@import MapKit;
@import AddressBook;

@interface ZipCodeViewController ()<UITextFieldDelegate, CLLocationManagerDelegate>
{
    
//    NSMutableData *receivedData;
    CLLocationManager *locationManager;
    CLGeocoder *geocoder;
}

- (IBAction)findCityButton:(UIButton *)sender;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

- (IBAction)findCurrentLocation:(UIButton *)sender;

@property (weak, nonatomic)IBOutlet UIButton *currentLocationButton;

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end

@implementation ZipCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationItem.prompt = @"Please enter a zipcode to find the current weather conditions";
    self.title = @"Add a City";
    geocoder = [[CLGeocoder alloc] init];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
        [self.currentLocationButton setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status != kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [self.currentLocationButton setEnabled:NO];
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
        [self.currentLocationButton setEnabled:NO];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error)
    {
        if ((placemarks != nil) && (placemarks.count > 0))
        {
            [self enableLocationManager:NO];
            NSString *cityName = [placemarks[0] locality];
            NSString *zipCode = [[placemarks[0] addressDictionary] objectForKey:(NSString *)kABPersonAddressZIPKey];
            double lat = location.coordinate.latitude;
            double lng = location.coordinate.longitude;
            City *aCity = [[City alloc] initWithName:cityName latitude:lat longitude:lng andZipcode:zipCode];
            [[NetworkManager sharedNetworkManager] cityFoundUsingCurrentLocation:aCity];
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Action Handlers

- (IBAction)findCityButton:(UIButton *)sender
{
    if (![self.zipCodeTextField.text isEqualToString:@""])
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        if ([self.zipCodeTextField.text length] == 5 && [self.zipCodeTextField.text rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            [self.zipCodeTextField resignFirstResponder];
            City *aCity = [[City alloc] initWithZipCode:self.zipCodeTextField.text];
            
           
            [[NetworkManager sharedNetworkManager] findCoordinatesForCity:aCity];

        }
    }

}

- (IBAction)findCurrentLocation:(UIButton *)sender
{
     [self configureLocationManager];
}


- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
    [self cancel];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextField delegate w/ Validation

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""])
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
       
        if ([textField.text length] == 5 && [textField.text rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            [textField resignFirstResponder];
            
            rc = YES;
        }
    }
    
    return rc;
}



@end
