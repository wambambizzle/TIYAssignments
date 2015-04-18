//
//  PriceCalculatorViewController.m
//  Coinless
//
//  Created by Jordan Anderson on 4/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "PriceCalculatorViewController.h"

@interface PriceCalculatorViewController () <NSURLSessionDataDelegate, UITextFieldDelegate>
{
    NSMutableData *_receivedData;
    double _usdRate;
    double _euroRate;
    double _britRate;
}

@property (weak, nonatomic) IBOutlet UITextField *usdTextField;
@property (weak, nonatomic) IBOutlet UITextField *euroTextField;
@property (weak, nonatomic) IBOutlet UITextField *poundsTextField;

@property (weak, nonatomic) IBOutlet UITextField *usdBitcoinTextField;
@property (weak, nonatomic) IBOutlet UITextField *euroBitcoinTextField;
@property (weak, nonatomic) IBOutlet UITextField *poundsBitcoinTextField;

- (void)coinDeskAPICall;

@end

@implementation PriceCalculatorViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self coinDeskAPICall];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TextField delegate

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

#pragma mark - Coinbase Api call


- (void)coinDeskAPICall
{
    NSString *urlString = @"https://api.coindesk.com/v1/bpi/currentprice.json";
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue mainQueue]];
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
    if (!_receivedData)
    {
        _receivedData = [[NSMutableData alloc] initWithData:data];
    }
    else
    {
        [_receivedData appendData:data];
    }
}

- (void) URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (!error)
    {
        NSLog(@"Download Successful.");
        NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:_receivedData options:0 error:nil];
        NSDictionary *coinBaseDict = [jsonData objectForKey:@"bpi"];
        // USD Parse
        NSDictionary *usdDict = [coinBaseDict objectForKey:@"USD"];
        NSString *usdRateString = [usdDict objectForKey:@"rate_float"];
       _usdRate = [usdRateString doubleValue];
        
        // Euro Parse
        NSDictionary *euroDict = [coinBaseDict objectForKey:@"EUR"];
        NSString *euroRateString = [euroDict objectForKey:@"rate_float"];
        _euroRate = [euroRateString doubleValue];
        
        // GBP Parse
        NSDictionary *britDict = [coinBaseDict objectForKey:@"GBP"];
        NSString *britRateString = [britDict objectForKey:@"rate_float"];
        _britRate = [britRateString doubleValue];

        NSLog(@"us:%f, euro:%f, brit:%f",_usdRate, _euroRate, _britRate);
        
        
    }
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
