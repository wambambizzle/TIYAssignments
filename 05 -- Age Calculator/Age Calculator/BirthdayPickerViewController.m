//
//  BirthdayPickerViewController.m
//  Age Calculator
//
//  Created by Jordan Anderson on 3/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "BirthdayPickerViewController.h"

@interface BirthdayPickerViewController ()

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;


@end

@implementation BirthdayPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   
}

- (void)viewWillDisappear:(BOOL)animated
{

    [super viewWillDisappear:animated];
    
    [self.delegate birthdayDateWasChoosen:self.datePicker.date]; // more info
    //^ viewctrler object calling a method on the delegate that returns the birthday choose from the date picker
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
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
