//
//  PricesCalculationsTableViewController.m
//  Coinless
//
//  Created by Jordan Anderson on 4/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "PricesCalculationsTableViewController.h"

@interface PricesCalculationsTableViewController ()<NSURLSessionDataDelegate, UITextFieldDelegate>
{
    NSMutableData *_receivedData;
    NSString *_usdRate;
    NSString *_euroRate;
    NSString *_poundsRate;
}

- (IBAction)clearCalcValuesTapped:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *usdTextField;
@property (weak, nonatomic) IBOutlet UITextField *euroTextField;
@property (weak, nonatomic) IBOutlet UITextField *poundsTextField;

@property (weak, nonatomic) IBOutlet UITextField *usdBitcoinTextField;
@property (weak, nonatomic) IBOutlet UITextField *euroBitcoinTextField;
@property (weak, nonatomic) IBOutlet UITextField *poundsBitcoinTextField;

- (void)coinDeskAPICall;
//- (void)calcAllValues;


@end

@implementation PricesCalculationsTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Bitcoin Calculator";
    
    [self coinDeskAPICall];
    
    self.usdTextField.text = @"";
    self.euroTextField.text = @"";
    self.poundsTextField.text = @"";
    
    self.usdBitcoinTextField.text = @"";
    self.euroBitcoinTextField.text = @"";
    self.poundsBitcoinTextField.text = @"";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

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
    return 4;
}


- (void)preformCalcConversion
{
    if (![self.usdTextField.text isEqualToString:@""] && [self.usdBitcoinTextField.text isEqualToString:@""])
    {
        float bitVal = [self.usdTextField.text floatValue] / [_usdRate floatValue];
        self.usdBitcoinTextField.text = [NSString stringWithFormat:@"฿%g", bitVal];
    }
    else if (![self.usdBitcoinTextField.text isEqualToString:@""] && [self.usdTextField.text isEqualToString:@""] )
    {
        float currencyVal = [self.usdBitcoinTextField.text floatValue] * [_usdRate floatValue];
        self.usdTextField.text = [NSString stringWithFormat:@"$%g", currencyVal];
    }
    else if (![self.euroTextField.text isEqualToString:@""] && [self.euroBitcoinTextField.text isEqualToString:@""])
    {
        float bitVal = [self.euroTextField.text floatValue] / [_euroRate floatValue];
        self.euroBitcoinTextField.text = [NSString stringWithFormat:@"฿%g", bitVal];
    }
    else if (![self.euroBitcoinTextField.text isEqualToString:@""] && [self.euroTextField.text isEqualToString:@""] )
    {
        float currencyVal = [self.euroBitcoinTextField.text floatValue] * [_euroRate floatValue];
        self.euroTextField.text = [NSString stringWithFormat:@"€%g", currencyVal];
    }
    else if (![self.poundsTextField.text isEqualToString:@""] && [self.poundsBitcoinTextField.text isEqualToString:@""])
    {
        float bitVal = [self.poundsTextField.text floatValue] / [_poundsRate floatValue];
        self.poundsBitcoinTextField.text = [NSString stringWithFormat:@"฿%g", bitVal];
    }
    else if (![self.poundsBitcoinTextField.text isEqualToString:@""] && [self.poundsTextField.text isEqualToString:@""] )
    {
        float currencyVal = [self.poundsBitcoinTextField.text floatValue] * [_poundsRate floatValue];
        self.poundsTextField.text = [NSString stringWithFormat:@"£%g", currencyVal];
    }
    
}

#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc;
    
    if (![textField.text isEqualToString:@""])
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
        
        if ([textField.text rangeOfCharacterFromSet:set].location != NSNotFound)
        {
            if (![textField.text isEqualToString:@""])
            {
                rc = YES;
                textField.delegate = self;
                [self preformCalcConversion];
                if (textField == self.usdTextField)
                {
                    [self.euroTextField becomeFirstResponder];
                }
                else if (textField == self.euroTextField)
                {
                    [self.poundsTextField becomeFirstResponder];
                }
                else if (textField == self.usdBitcoinTextField)
                {
                    [self.euroBitcoinTextField becomeFirstResponder];
                }
                else if (textField == self.euroBitcoinTextField)
                {
                    [self.poundsBitcoinTextField becomeFirstResponder];
                }
                
            }
            [textField resignFirstResponder];
            
        }
        
    }
    
    return YES;
}

- (IBAction)clearCalcValuesTapped:(id)sender
{
    self.usdTextField.text = @"";
    self.euroTextField.text = @"";
    self.poundsTextField.text = @"";
    self.usdBitcoinTextField.text = @"";
    self.euroBitcoinTextField.text = @"";
    self.poundsBitcoinTextField.text = @"";
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
        _usdRate = [usdDict objectForKey:@"rate_float"];
        
        // Euro Parse
        NSDictionary *euroDict = [coinBaseDict objectForKey:@"EUR"];
        _euroRate = [euroDict objectForKey:@"rate_float"];
        
        // GBP Parse
        NSDictionary *britDict = [coinBaseDict objectForKey:@"GBP"];
        _poundsRate = [britDict objectForKey:@"rate_float"];
        
    }
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) 
    {
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
