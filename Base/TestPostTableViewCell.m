//
//  TestPostTableViewCell.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "TestPostTableViewCell.h"

@implementation TestPostTableViewCell

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
    // do setup here
    self.profileImage.layer.cornerRadius = 25.0f;
    self.profileImage.clipsToBounds = YES;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)commentButtonTapped:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"CommentButtonTapped" object:nil];
}
@end
