//
//  LegendTableViewCell.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/26/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "LegendTableViewCell.h"

@implementation LegendTableViewCell

@synthesize textLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)anotherDecoder {
    self = [super initWithCoder:anotherDecoder];
    
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [_checkmarkImageView.layer setCornerRadius:.5 * _checkmarkImageView.frame.size.height ];
    _checkmarkImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
