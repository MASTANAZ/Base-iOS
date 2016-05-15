//
//  FirstViewController.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSDictionary *dictOfDataToPass;

@property (weak, nonatomic) IBOutlet UITableView *feedTableView;


- (IBAction)addPost:(id)sender;

@end

