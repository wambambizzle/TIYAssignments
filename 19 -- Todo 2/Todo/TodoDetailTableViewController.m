//
//  TodoDetailTableViewController.m
//  Todo
//
//  Created by Jordan Anderson on 3/27/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoDetailTableViewController.h"

#import "TodoTableViewController.h"

#import "TodoItem.h"

@interface TodoDetailTableViewController ()

@property (weak, nonatomic) IBOutlet UIButton *checkMarkButton;

@property (weak, nonatomic) IBOutlet UITextField *taskTitleTextField;

@property (weak, nonatomic) IBOutlet UILabel *datePickerLabel;

- (IBAction)localSearchTextFieldA:(UITextField *)sender;

@property (weak, nonatomic) IBOutlet UITextField *localSearchTextFieldO;


@property (weak, nonatomic) IBOutlet UITextView *notesTextView;
- (IBAction)deleteTaskButton:(UIButton *)sender;

@end

@implementation TodoDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.taskTitleTextField.text = self.aTask.taskName;
    
    self.checkMarkButton.selected = self.aTask.taskIsComplete;
    
    NSLog(@"title name: %@", self.aTask.taskName);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 5;
}

- (IBAction)deleteTaskButton:(UIButton *)sender
{
    
}

- (IBAction)localSearchTextFieldA:(UITextField *)sender
{
    
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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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
