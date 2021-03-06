//
//  TodoDetailTableViewController.m
//  Todo
//
//  Created by Jordan Anderson on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoDetailTableViewController.h"
#import "POIResultsTableViewController.h"

#import "TodoTableViewController.h"
#import "DueDatePickerViewController.h"

#import "TodoItem.h"

@import MapKit;
@import CoreLocation;

@interface TodoDetailTableViewController () <UITextFieldDelegate, CLLocationManagerDelegate>
{
    NSDateFormatter *formatDate;
    NSString *selectedDueDate;
    
    CLLocationManager *locationManager;
    MKLocalSearch *localSearch;
    MKLocalSearchResponse *results;
}

@property (weak, nonatomic) IBOutlet UIButton *checkMarkButton;

@property (weak, nonatomic) IBOutlet UITextField *localSearchTextField;

@property (weak, nonatomic) IBOutlet UITextField *taskTitleTextField;

@property (weak, nonatomic) IBOutlet UILabel *datePickerLabel;

@property (weak, nonatomic) IBOutlet UITextView *notesTextView;

- (IBAction)deleteTaskButton:(UIButton *)sender;

@end

@implementation TodoDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.taskTitleTextField.text = self.aTask.taskName;
    
    self.checkMarkButton.selected = self.aTask.taskIsComplete;
    
    formatDate = [[NSDateFormatter alloc] init];
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MMMddyyyy"
                                                             options:0
                                                              locale:[NSLocale currentLocale]];

    [formatDate setDateFormat:formatString];
    
    self.aTask.notes = self.notesTextView.text;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.localSearchTextField.text = self.aTask.addressName;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.notesTextView.text = self.aTask.notes;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 5;
}

- (IBAction)deleteTaskButton:(UIButton *)sender
{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender   
{
    if ([segue.identifier isEqualToString:@"DueDatePickerSegue"])
    {

        UINavigationController *navC = [segue destinationViewController];
        DueDatePickerViewController *dueDateVC = [navC viewControllers][0];
        dueDateVC.delegate = self;
    }
}



#pragma mark - UITextField delegates w/ Local Search

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""])
    {
        if (textField == self.localSearchTextField  && ![textField.text isEqualToString:@""])
        {
           [self configureLocationManager];
            rc = YES;
        }
        
        // need to add logic for if they change the aTask.name
    }
    
    return rc;
}

//#pragma mark - Configure map view
//
//- (void)configureMapView
//{
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance([self.currentLocation coordinate], MAP_DISPLAY_SCALE, MAP_DISPLAY_SCALE);
//    [self.mapView setRegion:viewRegion]; //where the map goes
//    
//}

//- (void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField == self.localSearchTextField)
//    {
//        
//    }
//}


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
    MKCoordinateRegion userLocation = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 1500.00, 1500.00);
    [self performSearch:userLocation];
    
}

-(void)performSearch:(MKCoordinateRegion)aRegion
{
    // Cancel any previous searches.
    [localSearch cancel];
    
    [locationManager stopUpdatingLocation];
    
    // Perform a new search.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.localSearchTextField.text;
    request.region = aRegion;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error != nil) {
            [[[UIAlertView alloc] initWithTitle:@"Map Error"
                                        message:[error localizedDescription]
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            return;
        }
        
        if ([response.mapItems count] == 0) {
            [[[UIAlertView alloc] initWithTitle:@"No Results"
                                        message:nil
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            return;
        }
        
        results = response;
    
                
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navC = [storyboard instantiateViewControllerWithIdentifier:@"LocationNavController"];
        POIResultsTableViewController *poiTVC = [navC viewControllers][0]; // <- [0] same as object at index to get a spot of an array
        
        [poiTVC setModalPresentationStyle:UIModalPresentationFullScreen];
        
        poiTVC.locationsArray = response.mapItems;
        poiTVC.aTask = self.aTask;
        
        [self presentViewController:navC animated:YES completion:nil];
        
    }];
    
//    NSLog(@"DEBUG");
    
}

- (void)taskDueDateWasChosen:(NSDate *)dueDate
{
    self.datePickerLabel.text = [formatDate stringFromDate:dueDate];
    self.aTask.dueDate = dueDate;
    NSLog(@"%@", self.aTask.dueDate);
}

@end
