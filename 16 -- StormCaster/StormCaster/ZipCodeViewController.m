//
//  ZipCodeViewController.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ZipCodeViewController.h"
#import "Weather.h"

@interface ZipCodeViewController ()<UITextFieldDelegate, NSURLSessionDataDelegate>
{
    
    NSMutableData *receivedData;
}

- (IBAction)findCityButton:(UIButton *)sender;

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UITextField *zipCodeTextField;

@end

@implementation ZipCodeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.prompt = @"Please enter a zipcode to find the weather of the current weather conditions";
    self.title = @"Add a City";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)findCityButton:(UIButton *)sender
{
    NSString *zipcode = self.zipCodeTextField.text;
    NSString *urlString = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/geocode/json?address=santa+cruz&components=postal_code:%@&sensor=false", zipcode];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];
    
}

#pragma mark - NSURLSessionData Delegate

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
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
//        NSLog(@"Download successful.");
        NSDictionary *weatherData = [NSJSONSerialization JSONObjectWithData:receivedData
                                                options:0
                                                error:nil];
        
        Weather *weatherItem = [[Weather alloc] init];
                
        NSArray *results = [weatherData objectForKey:@"results"];
        NSDictionary *locationInfo = results[0];
        NSArray *addressComps = [locationInfo objectForKey:@"address_components"];
        NSDictionary *city = addressComps[1];
        NSString *cityName = [city objectForKey:@"long_name"];
        
        weatherItem.weatherCity = cityName;
        
        NSDictionary *geometry = [locationInfo objectForKey:@"geometry"];
        NSDictionary *location = [geometry objectForKey:@"location"];
        NSString *lat = [location objectForKey:@"lat"];
        NSString *lng = [location objectForKey:@"lng"];
        
        weatherItem.weatherLat = lat;
        weatherItem.weatherLng = lng;
        
//        [weatherItem updateWeather];
        
        [self.cities addObject:weatherItem];
        
        
        [self cancel];
    }
    else if (error)
    {
        NSLog(@"Please try again");
    }
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
