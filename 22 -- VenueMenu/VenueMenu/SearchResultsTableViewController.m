//
//  SearchResultsTableViewController.m
//  VenueMenu
//
//  Created by Jordan Anderson on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "SearchResultsTableViewController.h"

#import "Location.h"
#import "Venue.h"

#import "NetworkManager.h"

#define kClientID @"TM24RIHKVXWTSNQS1OHJWTWDHUD3R52Q5HNL5QIWB4N31LT5"
#define kClientSecret @"VVBKQBAE2IBCMDNOYAOJ1ZEQDSE4FYMBOT3ET5HQUTEHGFMZ"


@import MapKit;
@import CoreLocation;

@interface SearchResultsTableViewController () <UITextFieldDelegate, CLLocationManagerDelegate, NSURLSessionDataDelegate>
{
    NSMutableArray *resultsArray;
    CLLocationManager *locationManager;
    NSMutableData *receivedData;
    double userLat;
    double userLng;
    Venue *aVenue;
    
}

@property (weak, nonatomic) IBOutlet UITextField *venueSearchTextField;

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    resultsArray = [[NSMutableArray alloc] init];
    self.venueSearchTextField.delegate = self;

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
    return resultsArray.count;
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
    
//     cell.textLabel.text = aVenue.name;
    
    return cell;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - UITextField delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] )
    {
        [textField resignFirstResponder];
        rc = YES;
        
        [self configureLocationManager];
        
    }
    else if ([textField.text isEqualToString:@""])
    {
        [textField becomeFirstResponder];
        
    }
    
    return rc;
}

#pragma mark - API call



-(void)foursquareURLSession
{
    NSString *querySearch = self.venueSearchTextField.text;
//    NSLog(@"querySearch used: %@", querySearch);
    NSString *urlString = [NSString stringWithFormat:@"https://api.foursquare.com/v2/venues/search?client_id=%@&client_secret=%@&v=20130815&ll=%f,%f&query=%@&radius=800",kClientID,kClientSecret,userLat,userLng,querySearch];
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
        NSLog(@"Download Successful.");
        NSDictionary *venueInfo = [NSJSONSerialization JSONObjectWithData:receivedData options:0 error:nil];
        [resultsArray addObject:venueInfo];
        
//        NSDictionary *response = [venueInfo objectForKey:@"response"];
//        NSArray *venues = [response objectForKey:@"venues"];
//        NSDictionary *firstLocation = [venues objectAtIndex:0];
//        aVenue.name = [firstLocation objectForKey:@"name"];
//        
//        NSLog(@"%@",aVenue.name);
        
        
        
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
    
//    NSLog(@"lat:%f, lng:%f", userLat, userLng);
    
        [self foursquareURLSession];
    
//    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1500.00, 1500.00);
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath 
 {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath 
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
