//
//  ExpandedMapTableViewController.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/25/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandedMapTableViewController : UITableViewController

@property (strong, nonatomic) NSDictionary *passedInInfoDict;
@property (strong, nonatomic) NSArray *sectionTitles;
@property (strong, nonatomic) NSString *mapObjectType;
@property (strong, nonatomic) NSString *passedInTitle;

@end
