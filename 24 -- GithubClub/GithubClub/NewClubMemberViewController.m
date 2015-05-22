//
//  NewClubMemberViewController.m
//  GithubClub
//
//  Created by Jordan Anderson on 4/20/15.
//  Copyright (c) 2015 tiy. All rights reserved.
//

#import "NewClubMemberViewController.h"

@interface NewClubMemberViewController () <NSURLSessionDataDelegate, UITextFieldDelegate>
{
   
    NSMutableData *_receivedData;
}

@property (strong,nonatomic) IBOutlet UITextField *usernameTextField;

-(IBAction)cancelButtonTapped:(id)sender;
-(IBAction)addNewClubTapped:(id)sender;

@end

@implementation NewClubMemberViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addNewClubTapped:(id)sender
{
    NSString *username = self.usernameTextField.text;
    NSString *urlString = [NSString stringWithFormat:@"https://api.github.com/users/%@", username];
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:url];
    
    [dataTask resume];


}

-(IBAction)cancelButtonTapped:(id)sender
{
    [self cancel];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:_receivedData options:0 error:nil];
        [self.friends addObject:userInfo];
//        NSLog(@"%@", self.friends);

        [self cancel];
    }
    else if (error)
    {
        NSLog(@"Sorry there was an error");
    }
}

//#pragma mark - TextField delegate
//
//- (BOOL)textFieldShouldReturn:(UITextField *)textField
//{
//    BOOL rc = YES;
//    
//    if (textField == self.usernameTextField && [self.usernameTextField.text isEqualToString:@""])
//    {
//        rc = NO;
//        [self.usernameTextField becomeFirstResponder];
//    }
//    else if (![self.usernameTextField.text isEqualToString:@""])
//    {
//        [self.usernameTextField resignFirstResponder];
//    }
//    
//    return rc;
//
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
