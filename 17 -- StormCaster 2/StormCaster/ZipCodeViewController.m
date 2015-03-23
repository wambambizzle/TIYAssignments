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
//    self.navigationItem.prompt = @"Please enter a zipcode to find the current weather conditions";
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
