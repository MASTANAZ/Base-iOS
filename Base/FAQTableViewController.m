//
//  FAQTableViewController.m
//  Base
//
//  Created by Blake Nazario on 4/21/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "FAQTableViewController.h"

@interface FAQTableViewController ()

@end

@implementation FAQTableViewController

// NOTE:
//       Section titles will be gotten from a network, downloaded if there are new ones. Similar to how profile images are downloaded, and similar to
//       how the Map detail views are dynamic with sections


NSArray *sectionTitles;
NSArray *questions;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    
    // Temp data
    sectionTitles = [[NSArray alloc]initWithObjects:@"Is this app secure?", @"How do I add more users to my Base?", @"More questions coming soon.", nil];
    questions = [[NSArray alloc]initWithObjects:@"Yes; Base utilizes industry standard SSL encryption. Below the SSL surface, Base encrypts its data using AES-256 encryption in CBC mode.\n\n In short, this ensures that data is encrypted on multiple levels that would all need to be bypassed in order to see what data was actually being shown.", @"Currently, the only person that can accept or decline requests to join your Base are your Base administrators.", @"Stay tuned.", nil];
    
    [self.tableView setUserInteractionEnabled:NO];
    
    [self.tableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
    self.navigationItem.title = @"FAQ";
    
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
    return sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [sectionTitles objectAtIndex: section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FAQcell" forIndexPath:indexPath];
    
    cell.textLabel.text = [questions objectAtIndex:indexPath.section];
    
    
    return cell;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 0, self.tableView.frame.size.width, 70.0f);
    headerLabel.font = [UIFont systemFontOfSize:16];
    headerLabel.textColor = [UIColor lightGrayColor];
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    
    UIView *headerView = [[UIView alloc] init];
    
    headerView.backgroundColor = [UIColor clearColor];
    
    headerView.frame = headerView.bounds;
    headerView.backgroundColor = [UIColor colorWithRed:240/255.0f green:240/255.0f blue:240/255.0f alpha:1.0f];
    [headerView addSubview:headerLabel];
    [headerView bringSubviewToFront:headerLabel];
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
