//
//  DueDatePickerViewController.m
//  Todo
//
//  Created by Jordan Anderson on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "DueDatePickerViewController.h"

#import "TodoItem.h"

@interface DueDatePickerViewController ()
{
    NSDateFormatter *formattDate;
    
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender;

- (IBAction)donePickDateButton:(UIBarButtonItem *)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation DueDatePickerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
     [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(UIBarButtonItem *)sender
{
    [self cancel];
}

- (IBAction)donePickDateButton:(UIBarButtonItem *)sender
{
    [self.delegate taskDueDateWasChosen:self.datePicker.date];
    

    [self cancel];
}


- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}









@end
