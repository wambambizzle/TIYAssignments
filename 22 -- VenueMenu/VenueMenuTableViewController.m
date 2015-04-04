//
//  VenueMenuTableViewController.m
//  VenueMenu
//
//  Created by Jordan Anderson on 4/2/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "VenueMenuTableViewController.h"

#import "SearchResultsTableViewController.h"

#import "CoreDataStack.h"

@import MapKit;
@import CoreLocation;

@interface VenueMenuTableViewController () 
{
    NSMutableArray *venuesArray;

}


@end

@implementation VenueMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.title =@"Venue Menu";
    
    
    venuesArray = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ListItem" inManagedObjectContext:cdStack.managedObjectContext];
//    
//    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
//    fetch.entity = entity;
//    
//    venuesArray = nil;
//    venuesArray = [[cdStack.managedObjectContext executeFetchRequest:fetch error:nil] mutableCopy];
//    
//    [self.tableView reloadData];
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
    
    // Configure the cell...
    
    return cell;
}

//#pragma mark - Navigation
//
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"AddVenueSegue"])
//    {
//        UINavigationController *navC = [segue destinationViewController];
//        SearchResultsTableViewController *resultsTVC = [navC viewControllers][0];
//
//    }
//}


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
