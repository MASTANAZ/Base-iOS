//
//  ExpandedPostTableViewController.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/25/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "ExpandedPostTableViewController.h"

//// Cells
#import "TestPostTableViewCell.h"
////

@interface ExpandedPostTableViewController ()

@end

@implementation ExpandedPostTableViewController

NSArray *commentsArray;

NSDictionary *commentOne;
NSDictionary *commentTwo;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Expanded Post View Did Load");
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    
    // The Passed in dict of data will include the post's ID.
    //
    // Execute an async request to get the comments of the post based on its ID
    // here.
    //
    // Then, add the comments to an array and use that array to populate the rest of the cells.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayKeyboardToAddComment) name:@"CommentButtonTapped" object:nil];
    
    commentOne =  @{@"CommentType":@"1",
                    @"User":@"Dylan Rodgers",
                    @"Timestamp":@"Today, 03:45 PM", // EEEE, MMM dd, yyyy, HH:mm",
                    @"CommentBody":@"Great post."
                    };
    commentTwo =  @{@"CommentType":@"1",
                    @"User":@"Blake Nazario-Casey",
                    @"Timestamp":@"Today, 12:15 PM", // EEEE, MMM dd, yyyy, HH:mm",
                    @"CommentBody":@"II agree."
                    };
    
    commentsArray = [[NSArray alloc]initWithObjects: commentOne, commentTwo, nil];
    [self.tableView reloadData];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    NSLog(@"Passed in post dict: %@", _passedInPostDict);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)displayKeyboardToAddComment {
    // Update table to add a new row and then allow the user to fill in the post themself
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the Original post plus the count of comments. Even if there are 0 comments,
    // the number of cells will still be 1.
    return commentsArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"*** Expanded post *** IndexPath.row of the table: %li", indexPath.row);
    
    if (indexPath.row == 0) {
        NSLog(@"*** Expanded post *** Index path.row = 0");
        TestPostTableViewCell *textPostCell = (TestPostTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"PostCell"];
        
        if ([[_passedInPostDict objectForKey:@"PostType"] isEqualToString:@"1"]) {

            textPostCell.username.text = [[_passedInPostDict objectForKey:@"User"] objectForKey:@"UserName"];
            textPostCell.timestamp.text = [_passedInPostDict objectForKey:@"Timestamp"];
            textPostCell.body.text = [_passedInPostDict objectForKey:@"PostBody"];
        }
        
        NSLog(@"**** Returning original post cell");
        
        return textPostCell;
    }

    else {
        
        TestPostTableViewCell *commentCell = (TestPostTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
        
        // Remember to subract 1 from the indexpath.row because the comments array does
        // not include the original post in its count.
        commentCell.username.text = [[commentsArray objectAtIndex:indexPath.row - 1]objectForKey:@"User"];
        commentCell.timestamp.text = [[commentsArray objectAtIndex:indexPath.row - 1] objectForKey:@"Timestamp"];
        commentCell.body.text = [[commentsArray objectAtIndex:indexPath.row - 1] objectForKey:@"CommentBody"];
        
        
        NSLog(@"**** Returning comment cell");
        
        return commentCell;
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
