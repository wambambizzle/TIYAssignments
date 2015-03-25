//
//  StormCasterTableViewController.m
//  StormCaster
//
//  Created by Jordan Anderson on 3/19/15.
//  Copyright (c) 2015 The Iron Yard. All rights reserved.
//

#import "StormCasterTableViewController.h"

#import "ZipCodeViewController.h"
#import "CityWeatherViewController.h"

#import "WeatherCell.h"

#import "Weather.h"

@interface StormCasterTableViewController () <UITextFieldDelegate>
{
    NSMutableArray *cities;
}

@end

@implementation StormCasterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Where You At";
    cities = [[NSMutableArray alloc] init];
    
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
    return cities.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
 {
    WeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WeatherCell" forIndexPath:indexPath];
    
     Weather *item = cities[indexPath.row];
     
     [item updateWeather];
     
     cell.cityLabel.text = item.city;
     cell.tempLabel.text = item.weatherTemp;
     
   
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([segue.identifier isEqualToString:@"ShowZipPresModal"])
    {
        UINavigationController *navController = [segue destinationViewController];
        ZipCodeViewController *zipCodeVC = [navController viewControllers ][0];
        zipCodeVC.cities = cities;
    }
//    if ([segue.identifier isEqualToString:@"ShowDetailCityWeatherSegue"])
//    {
//        UINavigationController *navController = [segue destinationViewController];
//        CityWeatherViewController *cityWVC = [navController viewControllers ][0];
//        
//        
//        NSLog(@"%@",cityWVC.cityDetails);
//    }
   
    
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Weather *selectedCity = cities[indexPath.row];
    CityWeatherViewController *cityWVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CityWeather"];
    cityWVC.aCity = selectedCity;
    
    [self.navigationController pushViewController:cityWVC animated:YES];
    
   

}




@end
