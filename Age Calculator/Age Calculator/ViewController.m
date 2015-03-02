//
//  ViewController.m
//  Age Calculator
//
//  Created by Jordan Anderson on 3/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ViewController.h"
#import "BirthdayPickerViewController.h"


@interface ViewController ()
{
    
 NSDateFormatter *formatDate;
 NSDate *usersBirthDate;
    
}

@property (weak, nonatomic) IBOutlet UILabel *currentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *usersBirthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *usersAgeLabel;



- (IBAction)calculateAge:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Age Calculator";
//    UIColor *joeCoolColor = [UIColor colorWithRed:<#(CGFloat)#> green:<#(CGFloat)#> blue:<#(CGFloat)#> alpha:<#(CGFloat)#>];
    
    
    formatDate = [[NSDateFormatter alloc] init];

    
    NSString *formatString = [NSDateFormatter dateFormatFromTemplate:@"MMM dd yyyy"
                                                             options:0
                                                              locale:[NSLocale currentLocale]];
    
    
    [formatDate setDateFormat:formatString];
    
    self.currentDateLabel.text = [formatDate stringFromDate:[NSDate date]];
    self.usersAgeLabel.text = @"--";
    self.usersBirthdayLabel.text = @"Please select your Birthdate";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"ShowBirthdateDatePickerSegue"])
    {
        BirthdayPickerViewController *bdayPickerVC = (BirthdayPickerViewController *)[segue destinationViewController];
        
        bdayPickerVC.delegate = self; // more infoooooo !
    }
    
}


#pragma mark - ViewControllerDelegate

- (void)birthdayDateWasChoosen:(NSDate *)birthdayDate
{
    self.usersBirthdayLabel.text = [formatDate stringFromDate:birthdayDate];
    usersBirthDate = birthdayDate;
}



- (IBAction)calculateAge:(UIButton *)sender
{
    
    
    NSDateComponents *todayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear fromDate: [NSDate date]];
    
    NSDateComponents *birthdayComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitYear fromDate:usersBirthDate];
    
    NSInteger age = todayComponents.year - birthdayComponents.year;
    
    if (todayComponents.month == birthdayComponents.month)
    {
        if (todayComponents.day == birthdayComponents.day)
        {
            self.usersAgeLabel.text = [NSString stringWithFormat:@"%ld years young", age];
        }
        else
        {
            age--;
            self.usersAgeLabel.text = [NSString stringWithFormat:@"%ld years young", age];
        }
    }
    
    else if (todayComponents.month > birthdayComponents.month)
    {
        self.usersAgeLabel.text = [NSString stringWithFormat:@"%ld years young", age];
    }
    
    else
    {
        age--;
        self.usersAgeLabel.text = [NSString stringWithFormat:@"%ld years young", age];
    }
        
    
}
























@end
