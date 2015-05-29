//
//  ViewController.m
//  Coinless
//
//  Created by Jordan Anderson on 4/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CoinlessViewController.h"
#import "CurrentRatesViewController.h"

@interface CoinlessViewController () 

@property (weak, nonatomic) IBOutlet UILabel *bitcoinInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentRatesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceCalcLabel;

@end

@implementation CoinlessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"- Coinless -";
//    self.bitcoinInfoLabel.layer.borderWidth = 3.0;
//    self.bitcoinInfoLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)bitcoinInfoTapped:(id)sender
{
    
[self performSegueWithIdentifier:@"ShowBitInfoSegue" sender:self];

}

- (IBAction)currentRatesTapped:(id)sender
{
    [self performSegueWithIdentifier:@"CurrentRatesSegue" sender:self];

}

- (IBAction)priceCalcTapped:(id)sender
{
    [self performSegueWithIdentifier:@"PriceCalcSegue" sender:self];
    
    NSLog(@"Price Calc Tapped");
}



@end
