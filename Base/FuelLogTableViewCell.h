//
//  FuelLogTableViewCell.h
//  Base
//
//  Created by Blake Nazario on 2/28/17.
//  Copyright © 2017 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FuelLogTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *gallonsLabel;
@property (weak, nonatomic) IBOutlet UILabel *apparatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
