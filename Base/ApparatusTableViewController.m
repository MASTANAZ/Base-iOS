//
//  ApparatusTableViewController.m
//  Base
//
//  Created by Blake Nazario on 8/10/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "ApparatusTableViewController.h"
#import "ApparatusOptionsTableViewController.h"

#import "MGSwipeTableCell.h"

@interface ApparatusTableViewController ()

@end

@implementation ApparatusTableViewController

// Temporary
static NSArray *apparatusArray;

NSString *selectedApparatus;

#warning Only officers should be able to take an apparatus in/out of service.


// Test Data
BOOL inService;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    inService = YES;
    
    // Temporary Data
    
    apparatusArray = @[@{@"Title":@"Engine 40", @"Body":@"Out of Service"},
                       @{@"Title":@"Squad 4", @"Body":@"In Service"},
                       @{@"Title":@"Brush 46", @"Body":@"In Service"},
                       @{@"Title":@"Tender 44", @"Body":@"In Service"},
                       @{@"Title":@"QR 4", @"Body":@"In Service"}];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return apparatusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MGSwipeTableCell *cell = (MGSwipeTableCell*)[tableView dequeueReusableCellWithIdentifier:@"ApparatusCell" forIndexPath:indexPath];
    
    
    /// TEST DATA FOR VISUALIZATION
    //TODO: Add functionality to update server with in/out of service information
    //      When server is updated, send push notification to users.
    if (indexPath.row % 2) {
        cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Take out of Service"
                                             backgroundColor:[UIColor colorWithRed:255.0/255 green:70.7/255 blue:76.5/255 alpha:1.0]
                                                    callback:^BOOL(MGSwipeTableCell *sender)
                               {
                                   NSLog(@"Take out");
                                   inService = NO;
                                   cell.detailTextLabel.text = @"Out of Service";
                                   

                                   return YES;
                               }]];
    }
    
    else {
        cell.rightButtons = @[[MGSwipeButton buttonWithTitle:@"Put in Service"
                                             backgroundColor:[UIColor colorWithRed:0.197 green:0.824 blue:0.295 alpha:1.0]
                                                    callback:^BOOL(MGSwipeTableCell *sender)
                               {
                                   NSLog(@"Put in");
                                   cell.detailTextLabel.text = @"In Service";
                                   inService = YES;
                                   
                                   
                                   return YES;
                               }]];
    }

    cell.textLabel.text = [[apparatusArray objectAtIndex:indexPath.row] objectForKey:@"Title"];
    cell.detailTextLabel.text = [[apparatusArray objectAtIndex:indexPath.row] objectForKey:@"Body"];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    selectedApparatus = cell.textLabel.text;
    
    [self performSegueWithIdentifier:@"ApparatusOptionsSegue" sender:self];
}

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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    ApparatusOptionsTableViewController *optionsTVC = (ApparatusOptionsTableViewController*)segue.destinationViewController;
    
    optionsTVC.apparatusName = selectedApparatus;
}


@end
