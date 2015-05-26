//
//  SearchResultsTableViewController.m
//  VenueMenu
//
//  Created by Jordan Anderson on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "SearchResultsViewController.h"

#import "Location.h"
#import "Venue.h"

#import "NetworkManager.h"

#define kClientID @"TM24RIHKVXWTSNQS1OHJWTWDHUD3R52Q5HNL5QIWB4N31LT5"
#define kClientSecret @"VVBKQBAE2IBCMDNOYAOJ1ZEQDSE4FYMBOT3ET5HQUTEHGFMZ"


@import MapKit;
@import CoreLocation;

@interface SearchResultsTableViewController () <CLLocationManagerDelegate,UISearchBarDelegate,NSURLSessionDataDelegate>
{
    CLLocationManager *locationManager;
    NSMutableData *receivedData;
    
    NSArray *venues;
    
    double userLat;
    double userLng;
    
}

@property (weak, nonatomic) IBOutlet UISearchBar *venueSearchBar;


@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.venueSearchBar.delegate = self;
    self.title = @"Search for a Venue";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return venues.count;
}


- (IBAction)cancelItemButton:(UIButton *)sender
{
    [self cancel];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResultsCell" forIndexPath:indexPath];
    
    NSDictionary *aVenue = venues[indexPath.row];
    
    NSString *name = [aVenue objectForKey:@"name"];
    
     cell.textLabel.text = name;
    
    NSDictionary *location = [aVenue objectForKey:@"location"];
    NSArray *addy = [location objectForKey:@"formattedAddress"];
    NSString *streetAddy = [addy objectAtIndex:0];
    NSString *citySate = [addy objectAtIndex:1];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ | %@",streetAddy,citySate];
    
    NSArray *categories = [aVenue objectForKey:@"categories"];
    NSDictionary *iconA = [categories objectAtIndex:0];
    NSDictionary *iconTrue = [iconA objectForKey:@"icon"];
    NSString *prefix = [iconTrue objectForKey:@"prefix"];
    NSString *suffix = [iconTrue objectForKey:@"suffix"];
    
    NSString *icon = [NSString stringWithFormat:@"%@44%@", prefix, suffix];
    NSURL *iconURL = [NSURL URLWithString:icon];
    NSData *imageData = [NSData dataWithContentsOfURL:iconURL];
    UIImage *image = [UIImage imageWithData:imageData];
    cell.imageView.image = image;
        
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *aVenue = [venues objectAtIndex:indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchResultsViewController *searchRVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchDetails"];
    searchRVC.aVenue = aVenue;
    searchRVC.cdStack = self.cdStack;
    [self showViewController:searchRVC sender:nil];
   
}

#pragma mark - SearchBar delegate


-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    if (locationManager)
    {
        [self foursquareURLSession];
    }
    
    [self configureLocationManager];
    

}


#pragma mark - API call

-(void)foursquareURLSession
{
    NSString *querySearch = self.venueSearchBar.text;
    NSString *escapedString = [querySearch stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
//    NSLog(@"querySearch used: %@", querySearch);
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=%f,%f&query=%@&radius=800",kClientID,kClientSecret,userLat,userLng,escapedString];
//     NSLog(@"%f, %f", userLat, userLng);
//    NSLog(@"urlstring:%@",urlString);
    NSURL *url = [NSURL URLWithString:urlString];
//    NSLog(@"url: %@",url);
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
}



#pragma mark - NSURLSession delegate

- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}


- (void) URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    if (!receivedData)
    {
        receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [receivedData appendData:data];
    }
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        
//        NSLog(@"Download Successful."); //RCL: take out in production
        NSDictionary *venueInfo = [NSJSONSerialization JSONObjectWithData:receivedData
                                                                 options:0
                                                                   error:nil]; // grab user info as dictionary
        NSDictionary *response = [venueInfo objectForKey:@"response"];
        
         venues = [response objectForKey:@"venues"];
    
        [self.tableView reloadData];
    }
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


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [self enableLocationManager:NO];
    
    CLLocation *newLocation = [locations lastObject];
    userLat = newLocation.coordinate.latitude;
    userLng = newLocation.coordinate.longitude;
    
      [self foursquareURLSession];
    
}



@end
