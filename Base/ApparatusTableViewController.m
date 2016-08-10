//
//  ApparatusTableViewController.m
//  Base
//
//  Created by Blake Nazario on 8/10/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "ApparatusTableViewController.h"
#import "ApparatusOptionsTableViewController.h"

@interface ApparatusTableViewController ()

@end

@implementation ApparatusTableViewController

// Temporary
static NSArray *apparatusArray;

NSString *selectedApparatus;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Temporary Data
    
    apparatusArray = @[@{@"Title":@"Engine 40", @"Body":@"In Service"},
                       @{@"Title":@"Squad 4", @"Body":@"In Service"},
                       @{@"Title":@"Brush 46", @"Body":@"In Service"},
                       @{@"Title":@"Tender 44", @"Body":@"In Service"},
                       @{@"Title":@"QR 4", @"Body":@"In Service"}];
    
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
    return apparatusArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ApparatusCell" forIndexPath:indexPath];
    

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
