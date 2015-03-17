//
//  CounterTableViewController.m
//  Counter
//
//  Created by Jordan Anderson on 3/17/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "CounterTableViewController.h"

#import "CountsTableViewCell.h"

#import "Count.h"



@interface CounterTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *counterList;
}

- (IBAction)addCounterItemButton:(UIBarButtonItem *)sender;
- (IBAction)clearAllButton:(UIBarButtonItem *)sender;

- (IBAction)counterAdd:(UIButton *)sender;
- (IBAction)counterMinus:(UIButton *)sender;

@end


@implementation CounterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Counter's Strike Back";
    counterList = [[NSMutableArray alloc] init];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CountsTableViewCell" bundle:nil] forCellReuseIdentifier:@"CounterCell"];
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
    return [counterList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CounterCell" forIndexPath:indexPath];
    
    cell.countDescriptionTextField.delegate = self;
    
    Count *item = counterList[indexPath.row];
    
    cell.countDescriptionTextField.text = @"";
    
    if (item.name)
    {
        cell.countDescriptionTextField.text = item.name;
    }
    else
    {
        [cell.countDescriptionTextField becomeFirstResponder];
    }
    
    return cell;
}


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
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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

#pragma mark - UITextField delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""])
    {
        [textField resignFirstResponder];
        
        UIView *contentView = [textField superview];
        UITableViewCell *cell = (UITableViewCell *)[contentView superview];
        NSIndexPath *path = [self.tableView indexPathForCell:cell];
        Count *anItem = counterList[path.row];
        anItem.name = textField.text;
        
        rc = YES;
    }
    
    return rc;
}

#pragma mark - Action Handlers

- (IBAction)addCounterItemButton:(UIBarButtonItem *)sender
{
    Count *aNewItem = [[Count alloc] init];
    [counterList addObject:aNewItem];
    
    NSUInteger row = [counterList indexOfObject:aNewItem];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (IBAction)counterAdd:(UIButton *)sender
{

    UIView *contentView = [sender superview];
    CountsTableViewCell *cell = (CountsTableViewCell *)[contentView superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    Count *anItem = counterList[path.row];
    
    [anItem calcCountUp];
    cell.countLabel.text = [NSString stringWithFormat:@"%2ld",(long)anItem.currentCount];
}

- (IBAction)counterMinus:(UIButton *)sender
{
    UIView *contentView = [sender superview];
    CountsTableViewCell *cell = (CountsTableViewCell *)[contentView superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    Count *anItem = counterList[path.row];
    
    [anItem calcCountDown];
    cell.countLabel.text = [NSString stringWithFormat:@"%2ld",(long)anItem.currentCount];
    
}


- (IBAction)clearAllButton:(UIBarButtonItem *)sender
{
    
}
@end
