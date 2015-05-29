//
//  CurrentRatesViewController.m
//  Coinless
//
//  Created by Jordan Anderson on 4/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CurrentRatesViewController.h"

@interface CurrentRatesViewController () <NSURLSessionDataDelegate>
{
    NSMutableData *_receivedData;

}

@property (weak, nonatomic) IBOutlet UILabel *usdRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *euroRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *poundsRateLabel;



@end

@implementation CurrentRatesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self coinDeskAPICall];
    self.title = @"Current Rates";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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
        NSDictionary *bitsDict = [NSJSONSerialization JSONObjectWithData:_receivedData options:0 error:nil];
        NSDictionary *coinBaseDict = [bitsDict objectForKey:@"bpi"];
        
        // USD Parse
        NSDictionary *usdDict = [coinBaseDict objectForKey:@"USD"];
        NSString *usdRateString = [usdDict objectForKey:@"rate_float"];
        double usdRate = [usdRateString doubleValue];
        self.usdRateLabel.text = [NSString stringWithFormat:@"$%g", usdRate];
        
        // Euro Parse
        NSDictionary *euroDict = [coinBaseDict objectForKey:@"EUR"];
        NSString *euroRateString = [euroDict objectForKey:@"rate_float"];
        double euroRate = [euroRateString doubleValue];
        self.euroRateLabel.text = [NSString stringWithFormat:@"€%g", euroRate];
        
        // GBP Parse
        NSDictionary *britDict = [coinBaseDict objectForKey:@"GBP"];
        NSString *britRateString = [britDict objectForKey:@"rate_float"];
        double britRate = [britRateString doubleValue];
        self.poundsRateLabel.text = [NSString stringWithFormat:@"£%g", britRate];
        
        
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
