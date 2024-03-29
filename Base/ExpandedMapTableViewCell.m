//
//  ExpandedMapTableViewCell.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/25/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "ExpandedMapTableViewCell.h"

@implementation ExpandedMapTableViewCell

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
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)openInMapsTapped:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"OpenMaps" object:nil];
}

- (IBAction)respondButtonTapped:(id)sender {
    //TODO: Notify the server/app/other users that user is responding to call.
    //
    //
    //  Execute async request here to update the list of responders.
    //
    // When list is retrieved, update the "Responders" cell
    
    if ([_respondButton.titleLabel.text isEqualToString:@"Respond"]) {
        
        [UIView animateWithDuration:.3 animations:^{
//            [_respondButton setTitleColor:[UIColor colorWithRed:0.0018 green:0.7632 blue:0.0073 alpha:1.0] forState:UIControlStateNormal];
//            [_respondButton setTitle:@"Responding..." forState:UIControlStateNormal];
            [_respondButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [_respondButton setTitle:@"Cancel Response..." forState:UIControlStateNormal];
            
            [UIView commitAnimations];
        } completion:^(BOOL finished)
         {
             UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Responding" message:@"Confirm that you are responding to this call. A notification will be sent to all other members of your station" delegate:self cancelButtonTitle:@"Nevermind" otherButtonTitles:@"Confirm", nil];
             [alert show];
        }];

    }
    
    else {
        [UIView animateWithDuration:.3 animations:^{
            [_respondButton setTitleColor:[UIColor colorWithRed:0.0392 green:0.3765 blue:0.9961 alpha:1.0] forState:UIControlStateNormal];
            [_respondButton setTitle:@"Respond" forState:UIControlStateNormal];
            [UIView commitAnimations];
        } completion:^(BOOL finished) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Cancel Response" message:@"Confirm that you are cancelling your response to this call. A notification will be sent to all other members of your station" delegate:self cancelButtonTitle:@"Nevermind" otherButtonTitles:@"Cancel Response", nil];
            [alert show];
        }];

    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RespondTapped" object:_respondButton];
}
@end
