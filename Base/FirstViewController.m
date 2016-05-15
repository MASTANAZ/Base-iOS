//
//  FirstViewController.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "FirstViewController.h"
#import "ExpandedPostTableViewController.h"
#import "ExpandedMapTableViewController.h"

//// Cells

#import "MapTableViewCell.h"
#import "TestPostTableViewCell.h"

////


#import "FeedAPI.h"

#import "TextPostModel.h"
#import "TextPostModel+TableRepresentation.h"

#import "MapPostModel.h"
#import "MapPostModel+TableRepresentation.h"




/*
 
 The main feed will pull posts for a specific date range that is TBD.
 
 This will be executed via a request specifying that date range (e.g serverIP:port/api/feed/getPostsForDateRange?=range) where the JSON following 
 the "feed/" will be an encrypted string,
 
 When the data is receieved in the API, use a NSNotification to let the app know the data has been recieved. Add the new data to the array of post, 
 then reload the table.
 
 */




@interface FirstViewController () {

    // TESTING
    NSArray *allPosts;
    NSDictionary *currentPostData;
    int currentPostIndex;
}

@end

@implementation FirstViewController

//  Cell Types
//
//  1 = Text Post
//  2 = Map Post
//  3 = Photo Post

NSArray *arrayOfPosts;

NSDictionary *postParams1;
NSDictionary *postParams2;
NSDictionary *postParams3;

NSString *selectedCallTypeTitle;

NSMutableArray *totalPosts;

static UIAlertController *addPostAlertController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    currentPostIndex = 0;
    allPosts = [[FeedAPI sharedInstance] getPosts]; // This will need to be maintained; For now, we can just get posts from the last two weeks. It will need to be mutable.
    totalPosts = [[NSMutableArray alloc]init];
    
    [self showDataForPostAtIndex:currentPostIndex];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    // Here we will load all of the posts asyncronously. Included in the
    // JSON of each post will ALSO be the POST's DATABASE ID.
    //
    // This will be used when needing to retrieve the comments of the post.
    //
    // When sending the dict to the expanded post VC, the POST'S ID MUST BE INCLUDED.
    //
    // The Expanded post VC will execute an async URL request to get the
    // comments by searching for the post by it's ID.

    
    postParams1 = @{@"PostType":@"1",
                    @"User":@"Dylan Rodgers",
                    @"Timestamp":@"Today, 03:45 PM", // EEEE, MMM dd, yyyy, HH:mm",
                    @"PostBody":@"ATTENTION: Please do not run emergent response to any Correctional Facility for a medical call. In an effort to keep ourselves and citizens on roadways safe, running emergent response to the prison just to get there and stage for an ambulance is uncalled for."
                    };
    
    postParams2 = @{@"PostType":@"2",
                    @"User":@"Alex Hatch",
                    @"Latitude":@"29.949689",
                    @"Longitude":@"-82.111474",
                    @"Address":@"13 N Lake St. Starke, FL 32091",
                    @"Timestamp":@"Today, 01:33 PM", // EEEE, MMM dd, yyyy, HH:mm",
                    @"CallType":@"Structure Fire",
                    @"Information":@"Structure fire ongoing. Engine 40 responding times 4. Station 5 and Station 2 are also responding. May need the tanker.",
                    @"Responders":@"Alex Hatch, Joel Haas, Ernie Williams, Dylan Rodgers"
                    };
    
    postParams3 = @{@"PostType":@"1",
                    @"User":@"Blake Nazario-Casey",
                    @"Timestamp":@"Today, 12:15 PM", // EEEE, MMM dd, yyyy, HH:mm",
                    @"PostBody":@"I will be up at the station all day on saturday this weekend."
                    };
    
    arrayOfPosts = [[NSArray alloc]initWithObjects: postParams1, postParams2, postParams3, nil];
    
//    NSLog(@"Array of posts: %@", arrayOfPosts);
    [self.feedTableView reloadData];
    
    self.feedTableView.dataSource = self;
    self.feedTableView.delegate = self;

    self.feedTableView.rowHeight = UITableViewAutomaticDimension;
    self.feedTableView.estimatedRowHeight = 100;
    
    [self initializeAlertController];
    
}





// showDataForAlbumAtIndex: fetches the required album data from the array of albums. When you want to present the new data,
//                          you just need to call reloadData.
- (void)showDataForPostAtIndex:(int)postIndex {
    
    NSLog(@"ALL POSTS: %@", allPosts);
    NSLog(@"CURRENT POST DATA: %@", currentPostData);

    NSLog(@"Post index: %i", postIndex);
    
    NSLog(@"\n\n\nTOTAL POSTS: %@", totalPosts);
    // defensive code: make sure the requested index is lower than the amount of albums
    if (postIndex < allPosts.count) {
         NSLog(@"Post index < allPosts.count");
        if ([[allPosts objectAtIndex:postIndex] isKindOfClass:[TextPostModel class]]){
            
            NSLog(@"Object at index '%i' of allPosts is a TEXT posts", postIndex);
            
            // fetch the post model
            TextPostModel *textPost = allPosts[postIndex];
            
            // save the albums data to present it later in the tableview
            currentPostData = [textPost tptr_textPostTableRepresentation];
            
            [totalPosts addObject:currentPostData];
            
        }
        
        // Post type = 2
        else {
            
            NSLog(@"Object at index '%i' of allPosts is a MAP posts", postIndex);
            
            // fetch the post model
            MapPostModel *mapPost = allPosts[postIndex];
            
            // save the data to present it later in the table view
            currentPostData = [mapPost mtr_mapTableRepresentation];
            
            [totalPosts addObject:currentPostData];
        }

    }
    
    else {
        currentPostData = nil;
    }
    

    // we have the data we need, let's refresh our tableview
        [self.feedTableView reloadData];
    
}








#pragma mark - UI

- (void)initializeAlertController {
    addPostAlertController = [UIAlertController alertControllerWithTitle:@"Create Post"
                                                                  message:[NSString stringWithFormat:@"Would you like to create a text post or post an active call?"]
                                                           preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       
                                   }];
    
    UIAlertAction *textPostAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Call In Progress"]
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * _Nonnull action)
                                   {
                                       [self createCall];
                                   }];
    
    UIAlertAction *callPostAction = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Text Post"]
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action)
                                     {
                                         [self createTextPost];
                                     }];
        
    [addPostAlertController addAction:cancelAction];
    [addPostAlertController addAction:textPostAction];
    [addPostAlertController addAction:callPostAction];
}


#pragma mark - Add Post

- (void)createTextPost {
    
}

- (void)createCall {
    
}


#pragma mark - TableView 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return arrayOfPosts.count;
    
    
    return [allPosts count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    
    currentPostIndex = currentPostIndex + 1;
    // Ensure to break the loop.
    if (currentPostIndex <= allPosts.count) {
        [self showDataForPostAtIndex:currentPostIndex];
    }
    if ([[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"PostType"] isEqualToString:@"1"]) {
        TestPostTableViewCell *textPostCell = (TestPostTableViewCell*)[self.feedTableView dequeueReusableCellWithIdentifier:@"TextCell"];

        textPostCell.username.text = [[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"User"] objectForKey:@"UserName"];
        textPostCell.timestamp.text = [[totalPosts objectAtIndex:indexPath.row]objectForKey:@"Timestamp"];
        textPostCell.body.text = [[totalPosts objectAtIndex:indexPath.row]objectForKey:@"PostBody"];

//        if ([[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"User"] containsString:@"Blake"]) {
//            textPostCell.profileImage.image = [UIImage imageNamed:@"Blake.png"];
//        }
//
//        else {
//            textPostCell.profileImage.image = [UIImage imageNamed:@"Rodgers.png"];
//        }
        textPostCell.feedProfileImageView = [[FeedProfileImageView alloc] initWithFrame:CGRectMake(0, 0, textPostCell.profileImage.frame.size.width, textPostCell.profileImage.frame.size.height)
                                                                        profileImageURL:[[[totalPosts objectAtIndex:indexPath.row] objectForKey:@"User"] objectForKey:@"profileImageURL"]
                                                                                forCell:textPostCell
                                                                                atIndex:indexPath.row];
        textPostCell.profileImage.layer.cornerRadius = 25.0f;
        
        NSLog(@"PROFILE VIEW INSTANCE: %@", textPostCell.feedProfileImageView);

        return textPostCell;
    }

    else if ([[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"PostType"] isEqualToString:@"2"]) {
        MapTableViewCell *mapCell = (MapTableViewCell*)[self.feedTableView dequeueReusableCellWithIdentifier:@"MapCell"];

        MKPointAnnotation*    annotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D myCoordinate;

        myCoordinate.latitude = [[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"Latitude"] doubleValue];
        myCoordinate.longitude = [[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"Longitude"] doubleValue];
        annotation.coordinate = myCoordinate;

        MKCoordinateRegion region;
        region.center.latitude = myCoordinate.latitude;
        region.center.longitude = myCoordinate.longitude;
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;

        [mapCell.mapView setRegion:region animated:YES];
        [mapCell.mapView addAnnotation:annotation];
        [mapCell.mapView setUserInteractionEnabled:NO];

        mapCell.callTypeTitle.text = [[totalPosts objectAtIndex:indexPath.row]objectForKey:@"CallType"];

        mapCell.timestamp.text = [[arrayOfPosts objectAtIndex:indexPath.row]objectForKey:@"Timestamp"];
        
#pragma warning Create assets for all other call types and fill them in here.
        if ([[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"CallType"] isEqualToString:@"Structure Fire"]) {
            mapCell.callTypeImage.image = [UIImage imageNamed:@"Base-MapAnnotation-Fire-2 copy.png"];
        }
        else if ([[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"CallType"] isEqualToString:@"Emergency Medical"]) {
            mapCell.callTypeImage.image = [UIImage imageNamed:@"Base-MapAnnotation-EmergencyMedical-2 copy.png"];
        }
        
        mapCell.callTypeImage.layer.cornerRadius = 25.0f;
        
        return mapCell;
    }

    else {
        return cell;
    }

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"PostType"] isEqualToString:@"1"]) {
//        TestPostTableViewCell *textPostCell = (TestPostTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TextCell"];
        
        //  To pass the data of the post, we can just access the dictionary of the post from the array of total posts.
        _dictOfDataToPass = [[NSDictionary alloc]initWithDictionary:[totalPosts objectAtIndex:indexPath.row]];
        
        [self performSegueWithIdentifier:@"ExpandedTextPostSegue" sender:self];
    }
    
    else if ([[[totalPosts objectAtIndex:indexPath.row]objectForKey:@"PostType"] isEqualToString:@"2"]) {
//        MapTableViewCell *mapCell = (MapTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        //  To pass the data of the post, we can just access the dictionary of the post from the array of total posts.
        _dictOfDataToPass = [[NSDictionary alloc]initWithDictionary:[totalPosts objectAtIndex:indexPath.row]];
        
        MapTableViewCell *selectedMapCell = (MapTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        selectedCallTypeTitle = [NSString stringWithString:selectedMapCell.callTypeTitle.text];
        
        [self performSegueWithIdentifier:@"ExpandedMapSegue" sender:self];
    }
    
    else {
        // Display alert controller.
    }
}


//- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ExpandedTextPostSegue"]) {
        ExpandedPostTableViewController *expandedTextPostVC = (ExpandedPostTableViewController*)segue.destinationViewController;
        
        expandedTextPostVC.passedInPostDict = [NSDictionary dictionaryWithDictionary:_dictOfDataToPass];
    }
    
    else if ([segue.identifier isEqualToString:@"ExpandedMapSegue"]){
        ExpandedMapTableViewController *expandedMapVC = (ExpandedMapTableViewController*)segue.destinationViewController;
        
        expandedMapVC.passedInInfoDict = _dictOfDataToPass;
        expandedMapVC.mapObjectType = @"1";
        expandedMapVC.sectionTitles = @[@"Location", @"Information", @"Responders"];
        
        expandedMapVC.passedInTitle = selectedCallTypeTitle;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPost:(id)sender {
    [self presentViewController:addPostAlertController animated:YES completion:nil];
}

@end
