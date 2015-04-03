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

@interface VenueMenuTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *venuesArray;
    CoreDataStack *cdStack;
}
@property (weak, nonatomic) IBOutlet UITextField *venueSearchTextField;

@end

@implementation VenueMenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    cdStack = [CoreDataStack coreDataStackWithModelName:@"VenueMenuModel"];
    cdStack.coreDataStoreType = CDSStoreTypeSQL;
    
    venuesArray = [[NSMutableArray alloc] init];
    self.venueSearchTextField.delegate = self;
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


#pragma mark - UITextField delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL rc = NO;
    
    if (![textField.text isEqualToString:@""] )
    {
        [textField resignFirstResponder];
        rc = YES;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UINavigationController *navC = [storyboard instantiateViewControllerWithIdentifier:@"SearchNavController"];
        SearchResultsTableViewController *searchTVC = [navC viewControllers][0]; // <- [0] same as object at index to get a spot of an array
        
        searchTVC.cdStack = cdStack;
        
        
        
        [searchTVC setModalPresentationStyle:UIModalPresentationFullScreen];
        
        [self presentViewController:navC animated:YES completion:nil];
        
        
    }
    else if ([textField.text isEqualToString:@""])
    {
        [textField becomeFirstResponder];

    }
    
    return rc;
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
