//
//  TodoTableViewController.m
//  Todo
//
//  Created by Jordan Anderson on 3/16/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "TodoTableViewController.h"

#import "TodoTableViewCell.h"

#import "TodoItem.h"

@interface TodoTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *taskList;
//    TodoItem taskIs

}
- (IBAction)createTodoItem:(UIButton *)sender;
- (IBAction)clearAllTaskItems:(UIButton *)sender;
- (IBAction)checkMarkButton:(UIButton *)sender;


@end

@implementation TodoTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Todo";
    taskList = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [taskList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
     TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell" forIndexPath:indexPath];
     
     TodoItem *item = taskList[indexPath.row];
     
//     cell.descriptionTextField.delegate = self;
     cell.descriptionTextField.text = @"";
     
         if (item.taskName)
         {
             cell.descriptionTextField.text = item.taskName;
         }
         else
         {
             [cell.descriptionTextField becomeFirstResponder];
         }
     
     [cell.checkboxButton setSelected:item.taskIsComplete];
     
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    // Return NO if you do not want the specified item to be editable.
     TodoItem *item = taskList[indexPath.row]; // gotta know which item you're looking at
     return item.taskIsComplete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
 {
        // Delete the row from the data source
        [taskList removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) 
 {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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
        TodoItem *anItem = taskList[path.row];
        anItem.taskName = textField.text;
        
        rc = YES;
    }
    
    return rc;
}

#pragma mark - Action Handlers

- (IBAction)createTodoItem:(id)sender
{
    TodoItem *aNewItem = [[TodoItem alloc] init];
    [taskList addObject:aNewItem];
    
    NSUInteger row = [taskList indexOfObject:aNewItem];
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (IBAction)clearAllTaskItems:(id)sender
{
    NSMutableArray *indexPathsToRemove = [[NSMutableArray alloc] init];
    NSMutableArray *itemsToRemove = [[NSMutableArray alloc] init];
    
    for (TodoItem *anItem in taskList)
    {
        if (anItem.taskIsComplete)
        {
            [itemsToRemove addObject:anItem];
            [indexPathsToRemove addObject:[NSIndexPath indexPathForRow:[taskList indexOfObject:anItem] inSection:0]];
        }
    }
    
    [taskList removeObjectsInArray:itemsToRemove];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToRemove withRowAnimation:UITableViewRowAnimationAutomatic];

    
}

- (IBAction)checkMarkButton:(UIButton *)sender
{
    UIView *contentView = [sender superview];
    UITableViewCell *cell = (UITableViewCell *)[contentView superview];
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    TodoItem *anItem = taskList[path.row];
    anItem.taskIsComplete = !anItem.taskIsComplete;
    [sender setSelected:anItem.taskIsComplete];
}




@end
