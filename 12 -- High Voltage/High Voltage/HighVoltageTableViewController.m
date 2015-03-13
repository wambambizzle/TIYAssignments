//
//  HighVoltageTableViewController.m
//  High Voltage
//
//  Created by Jordan Anderson on 3/12/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "HighVoltageTableViewController.h"
#import "PopUpCalculationsTableViewController.h"
#import "PowerCalculator.h"

@interface HighVoltageTableViewController () <UITextFieldDelegate, UIPopoverPresentationControllerDelegate>
{
    NSArray *energyList;
}


@end

@implementation HighVoltageTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    energyList = [[NSArray alloc] init];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [energyList count];
}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowPopUpCalcSegue"])
    {
        PopUpCalculationsTableViewController *desPopupCalcVC = (PopUpCalculationsTableViewController *)[segue destinationViewController];
        desPopupCalcVC.popoverPresentationController.delegate = self; // must set our "self" as a delegate of
        NSArray *energyTypes = [PowerCalculator allEnergyTypes]; // Calls our class method from PowerCalc and sets it in an Array
        float contentHeight = 44.0f * [energyTypes count]; // set the height of the modal to 44px * number of items in array
        desPopupCalcVC.preferredContentSize = CGSizeMake(100.0f, contentHeight); // giving a size to the pop over view width and height
    }
    
    
}


#pragma mark - Action Handlers

//-(IBAction)addPoweritem:(UIBarButtonItem *)sender
//{
//    PowerCalculator *anItem =[[PowerCalculator alloc] init];
//    [energyList addObject:anItem]; // add the Todo item to the task list array
//    [self.tableView reloadData]; // reload the table view aka update
//    
//}


@end
