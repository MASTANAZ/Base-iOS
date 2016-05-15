//
//  LegendTableViewCell.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/26/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LegendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mapItemTypeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *checkmarkImageView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end
