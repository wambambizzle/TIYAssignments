//
//  ListItemTableViewController.m
//  CoreList
//
//  Created by Jordan Anderson on 3/31/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "ListItemTableViewController.h"
#import "ViewController.h"

#import "ListItem.h"

#import "CoreDataStack.h"


@interface ListItemTableViewController ()
{
    NSMutableArray *listItemsArray;
    CoreDataStack *cdStack;
}

@end

@implementation ListItemTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    cdStack = [CoreDataStack coreDataStackWithModelName:@"CoreListModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    listItemsArray = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ListItem" inManagedObjectContext:cdStack.managedObjectContext];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = entity;
    
    listItemsArray = nil;
    listItemsArray = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
    
    [self.tableView reloadData];
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
    return listItemsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemListCell" forIndexPath:indexPath];
    
     ListItem *anItem = listItemsArray[indexPath.row];
     cell.textLabel.text = anItem.name;
    
    return cell;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddItemSegue"])
    {
        ViewController *addItemVC = [segue destinationViewController];
        addItemVC.cdStack = cdStack;
    }
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     NSManagedObjectContext *context = [cdStack managedObjectContext];
    if (editingStyle == UITableViewCellEditingStyleDelete) 
 {
        // Delete the row from the data source
     // Delete object from database
     [context deleteObject:[listItemsArray objectAtIndex:indexPath.row]];
     
     NSError *error = nil;
     if (![context save:&error]) {
         NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
         return;
     }
     
     // Remove device from table view
        [listItemsArray removeObjectAtIndex:indexPath.row];
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

@end
