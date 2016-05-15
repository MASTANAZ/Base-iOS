//
//  ExpandedMapTableViewController.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/25/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "ExpandedMapTableViewController.h"

//// Cells
#import "ExpandedMapTableViewCell.h"
#import "InfoTableViewCell.h"
////

@interface ExpandedMapTableViewController ()

@end

@implementation ExpandedMapTableViewController

#warning Rewriting this class to be generic; All Section Titles and data will be retrieved upon allocation from data passed in during segue.

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Passed in dict: %@", _passedInInfoDict);
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(openMapsApplication) name:@"OpenMaps" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(respondTapped:) name:@"RespondTapped" object:nil];
    
    if (_passedInTitle != nil) {
        NSLog(@"Title: %@", _passedInTitle);
        self.navigationItem.title = _passedInTitle;
    }
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)openMapsApplication {
    
    NSLog(@"Attempting to open in maps");

    NSString *addressString = [[NSString stringWithFormat: @"http://maps.apple.com/?daddr=%@,%@&dirflg=d",
                                [_passedInInfoDict objectForKey:@"Latitude"],
                                [_passedInInfoDict objectForKey:@"Longitude"]]
                                  stringByReplacingOccurrencesOfString:@" " withString:@"+"
                               ];
    
    NSURL *url = [NSURL URLWithString:addressString];
    [[UIApplication sharedApplication] openURL:url];
    
}

- (void)respondTapped:(NSNotification*)object {
    //Execute code here to update server, send notifications, etc.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.sectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    if (section == 0) {
//        return @"Location:";
//    }
//    
//    else if (section == 1) {
//        return @"Information:";
//    }
//    
//    else {
//        return @"Responders:";
//    }
    
    return [self.sectionTitles objectAtIndex:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSLog(@"Index path: %li", indexPath.section);

    
    if (indexPath.section == 0) {
        ExpandedMapTableViewCell *mapCell = [tableView dequeueReusableCellWithIdentifier:@"MapCell" forIndexPath:indexPath];
        
        MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D myCoordinate;
        
        myCoordinate.latitude = [[_passedInInfoDict objectForKey:@"Latitude"] doubleValue];
        myCoordinate.longitude = [[_passedInInfoDict  objectForKey:@"Longitude"] doubleValue];
        annotation.coordinate = myCoordinate;
        
        MKCoordinateRegion region;
        region.center.latitude = myCoordinate.latitude;
        region.center.longitude = myCoordinate.longitude;
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        
        [mapCell.mapView setRegion:region animated:YES];
        [mapCell.mapView addAnnotation:annotation];
        [mapCell.mapView setUserInteractionEnabled:YES];
        
        if ([[_passedInInfoDict allKeys] containsObject:@"InProgress"]) {
            if ([[_passedInInfoDict objectForKey:@"InProgress"] isEqualToString:@"0"]) {
//                [mapCell.respondButton setHidden:YES];
            
                [mapCell.respondButton setTitle:@"Expired" forState:UIControlStateNormal];
                [mapCell.respondButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [mapCell.respondButton setUserInteractionEnabled:NO];
            }
            
            else {
                
                [mapCell.respondButton setHidden:NO];
            }
        }
        
        else {
            [mapCell.respondButton setTitle:@"Expired" forState:UIControlStateDisabled];
            [mapCell.respondButton setHidden:YES];
        }
        
        return mapCell;
    }
    
    else {
        InfoTableViewCell *infoCell = (InfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
        
        NSLog(@"Third Section data: %@", [_sectionTitles objectAtIndex:indexPath.section]);
        
        infoCell.textLabel.text = [NSString stringWithFormat:@"%@", [_passedInInfoDict objectForKey:[_sectionTitles objectAtIndex:indexPath.section]]];
        
        return infoCell;
    }
    
//
//    else if (indexPath.section == 1) {
//        InfoTableViewCell *infoCell = (InfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
//        
//        infoCell.textLabel.text = [NSString stringWithFormat:@"Reported by: %@\n\n%@", [[_passedInInfoDict objectForKey:@"User"] objectForKey:@"UserName"], [_passedInInfoDict objectForKey:@"Information"]];
//        
//        return infoCell;
//    }
//    
//    else {
//        InfoTableViewCell *infoCell = (InfoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"InfoCell"];
//        
//            infoCell.textLabel.text = [NSString stringWithFormat:@"%@", [_passedInInfoDict objectForKey:@"Responders"]];
//        
//        return infoCell;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35.0f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(10, 0, self.tableView.frame.size.width, 40.0f);
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
