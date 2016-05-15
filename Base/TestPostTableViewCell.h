//
//  TestPostTableViewCell.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedProfileImageView.h"

@interface TestPostTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;
@property (weak, nonatomic) IBOutlet UILabel *body;
@property (strong, nonatomic) IBOutlet FeedProfileImageView *feedProfileImageView;

// Only for expanded posts
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
- (IBAction)commentButtonTapped:(id)sender;

@end
