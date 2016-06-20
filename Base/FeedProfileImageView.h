//
//  FeedProfileImageView.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedProfileImageView : UIView

- (id)initWithFrame:(CGRect)frame
    profileImageURL:(NSString *)profileImageURL
            forCell:(UITableViewCell*)cell
            atIndex:(NSInteger)index;

@end
