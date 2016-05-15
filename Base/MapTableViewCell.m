//
//  MapTableViewCell.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MapTableViewCell.h"

@implementation MapTableViewCell

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
//    // do setup here
    self.callTypeImage.layer.cornerRadius = 25.0f;
    self.callTypeImage.clipsToBounds = YES;
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
