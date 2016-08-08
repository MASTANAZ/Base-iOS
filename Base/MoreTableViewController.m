//
//  MoreTableViewController.m
//  Base
//
//  Created by Blake Nazario on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MoreTableViewController.h"

@interface MoreTableViewController ()

@end

@implementation MoreTableViewController

NSDictionary *optionsDict;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    optionsDict = [[NSDictionary alloc]initWithObjects:@[
                                                         @[@"Account Settings", @"Notification Settings", @"FAQ", @"Donate to the Developers", @"Log Out"],
                                                         @[@"Change Station, Password, Profile Name", @"Change when you receive notifications", @"Frequently Asked Questions", @"Donate to help allow updates for Base.", @"Log out of the application"]]
                                               forKeys: @[@"Title", @"Detail"]];
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
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
    return [[optionsDict objectForKey:@"Title"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OptionsCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[optionsDict objectForKey:@"Title"] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [[optionsDict objectForKey:@"Detail"] objectAtIndex:indexPath.row];
    
    // Logout
    if ([cell.textLabel.text isEqualToString:@"Log Out"]) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // FAQ
    if ([cell.textLabel.text isEqualToString:@"FAQ"]) {
        [self performSegueWithIdentifier:@"FAQsegue" sender:self];
    }
    
    else if ([cell.textLabel.text isEqualToString:@"Account Settings"]) {
        [self performSegueWithIdentifier:@"AccountSettingsSegue" sender:self];
    }
    
    else if ([cell.textLabel.text isEqualToString:@"Notification Settings"]) {
        [self performSegueWithIdentifier:@"NotificationSettingsSegue" sender:self];
    }
    
    else if ([cell.textLabel.text isEqualToString:@"Log Out"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log Out" message:@"Once you log out, the application will not automatically sign you in  until you reenter your credentials." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *logOutAction = [UIAlertAction actionWithTitle:@"Log Out" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            // Log out of the application here;
            
            [self performSegueWithIdentifier:@"LogoutSegue" sender:self];
        }];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // Log out of the application here;
            [self.tableView deselectRowAtIndexPath:[tableView indexPathForCell:cell] animated:YES];
        }];
        
        [alertController addAction:logOutAction];
        [alertController addAction:defaultAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    else if ([cell.textLabel.text isEqualToString:@"Donate to the Developers"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Continue to Safari?" message:@"To donate, you will be taken to Base's dontation site in the Safari application on your phone. Would you like to continue to Safari?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *safariButton = [UIAlertAction actionWithTitle:@"Open Safari" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            // Open safari website here;
            
            NSURL *url = [NSURL URLWithString:@"http://www.google.com"];
            
            if (![[UIApplication sharedApplication] openURL:url]) {
                NSLog(@"%@%@",@"Failed to open url:",[url description]);
                
                UIAlertController *openFailedAlert = [UIAlertController alertControllerWithTitle:@"Failed to Open URL" message:@"Failed to open URL." preferredStyle:UIAlertControllerStyleAlert];

                UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    // Log out of the application here;
                    [self.tableView deselectRowAtIndexPath:[tableView indexPathForCell:cell] animated:YES];
                }];
                
                [openFailedAlert addAction:defaultAction];
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }];
        
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            // Log out of the application here;
            [self.tableView deselectRowAtIndexPath:[tableView indexPathForCell:cell] animated:YES];
        }];
        
        [alertController addAction:safariButton];
        [alertController addAction:defaultAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
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
