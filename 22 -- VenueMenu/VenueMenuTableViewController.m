//
//  VenueMenuTableViewController.m
//  VenueMenu
//
//  Created by Jordan Anderson on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "VenueMenuTableViewController.h"

#import "SearchResultsTableViewController.h"
#import "SearchResultsViewController.h"

#import "CoreDataStack.h"
#import "Venue.h"

@import MapKit;
@import CoreLocation;

@interface VenueMenuTableViewController () 
{
    NSMutableArray *venuesArray;
     CoreDataStack *cdStack;

}


@end

@implementation VenueMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title =@"Venue Menu";
    
    cdStack = [CoreDataStack coreDataStackWithModelName:@"VenueMenuModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    
    venuesArray = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Venue" inManagedObjectContext:cdStack.managedObjectContext];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = entity;
    
    venuesArray = nil;
    venuesArray = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return venuesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VenueCell" forIndexPath:indexPath];
    
     Venue *theVenue = venuesArray[indexPath.row];
     cell.textLabel.text = theVenue.name;
     
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@ %@, %@", theVenue.streeAddress, theVenue.city, theVenue.state, theVenue.postalCode];
     
      [tableView deselectRowAtIndexPath:indexPath animated:YES];
     
    
    return cell;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AddVenueSearchSegue"])
    {
        UINavigationController *navC = [segue destinationViewController];
        SearchResultsTableViewController *searchTVC = [navC viewControllers][0];
        searchTVC.cdStack = cdStack;
    }
    
    else if ([segue.identifier isEqualToString:@"ShowDetailSegue"])
    {
        SearchResultsViewController *searchDetailsVC = [segue destinationViewController];
        //use the venu object
    }
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath 
 {

    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [cdStack managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the row from the data source
      [context deleteObject:[venuesArray objectAtIndex:indexPath.row]];
     [venuesArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
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





@end
