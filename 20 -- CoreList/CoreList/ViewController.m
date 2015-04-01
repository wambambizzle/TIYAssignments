//
//  ViewController.m
//  CoreList
//
//  Created by Jordan Anderson on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addTaskTextField;
- (IBAction)saveItemButton:(UIButton *)sender;
- (IBAction)cancelItemButton:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveItemButton:(UIButton *)sender
{
    if (![self.addTaskTextField.text isEqualToString:@""])
    {
        [self createNewItem];
        [self saveCoreDataUpdates];
        [self cancel];
    }
    
}


#pragma mark - TextField delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if ([textField.text isEqualToString:@""])
    {
        rc = YES;
        
        [self.addTaskTextField becomeFirstResponder];
      
    }
    else if (![textField.text isEqualToString:@""])
    {
        [self createNewItem];
//        [self saveCoreDataUpdates];
        [self.addTaskTextField resignFirstResponder];
    }
    
    return rc;
}

- (void)createNewItem
{
   ListItem *aItem = [NSEntityDescription insertNewObjectForEntityForName:@"ListItem" inManagedObjectContext:self.cdStack.managedObjectContext]; // using core data / database to create a student object for us
    
    aItem.name = self.addTaskTextField.text;
}

- (void)saveCoreDataUpdates
{
    [self.cdStack saveOrFail:^(NSError *errorOrNil)
     {
         if (errorOrNil)
         {
             NSLog(@"Error from CDStack: %@", [errorOrNil localizedDescription]);
         }
     }];

}

- (IBAction)cancelItemButton:(UIButton *)sender
{
    [self cancel];
}

-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
