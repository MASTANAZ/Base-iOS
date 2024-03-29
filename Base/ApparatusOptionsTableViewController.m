//
//  ApparatusOptionsTableViewController.m
//  Base
//
//  Created by Blake Nazario on 8/10/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "ApparatusOptionsTableViewController.h"
#import "ApparatusInventoryTableViewController.h"

@interface ApparatusOptionsTableViewController ()

@end

@implementation ApparatusOptionsTableViewController

// Not Temporary
static NSArray *apparatusOptionsList;

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.apparatusName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    apparatusOptionsList = @[@{@"Title":@"Inventory", @"Body":@"View most current apparatus inventory."},
                             @{@"Title":@"Perform Inspections", @"Body":@"Perform general inventory/equipment inspections."},
                             @{@"Title":@"Inspection History", @"Body":@"View past inspections."},
                             @{@"Title":@"Update Fuel Consumption", @"Body":@"Add fuel to apparatus fuel log."},
                             @{@"Title":@"Call History", @"Body":@"View past calls up to 2 weeks."}];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return apparatusOptionsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[apparatusOptionsList objectAtIndex:indexPath.row] objectForKey:@"Title"];
    cell.detailTextLabel.text = [[apparatusOptionsList objectAtIndex:indexPath.row] objectForKey:@"Body"];
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    if ([cell.textLabel.text isEqualToString:@"Inventory"]) {
        [self performSegueWithIdentifier:@"InventorySegue" sender:self];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InventorySegue"]) {
        ApparatusInventoryTableViewController *inventoryTVC = (ApparatusInventoryTableViewController*)segue.destinationViewController;

    }
}


@end
