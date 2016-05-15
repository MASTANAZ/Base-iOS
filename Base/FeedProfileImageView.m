//
//  FeedProfileImageView.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "FeedProfileImageView.h"

@interface FeedProfileImageView () {
    UIImageView *profileImage;
    UIActivityIndicatorView *indicator;
}

@end

@implementation FeedProfileImageView

- (id)initWithFrame:(CGRect)frame profileImageURL:(NSString *)profileImageURL forCell:(UITableViewCell*)cell atIndex:(NSInteger)index {
    self = [super initWithFrame:frame];
    if (self)
    {
        
        NSLog(@"*** FeedProfileImageView *** Cell: %@", cell);
        
        self.backgroundColor = [UIColor clearColor];
        // the profileImage has a 5 pixels margin from its frame
        profileImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-10, frame.size.height-10)];
        
        profileImage.layer.cornerRadius = .5 * profileImage.frame.size.width;
        [profileImage setClipsToBounds:YES];
        [profileImage setBackgroundColor:[UIColor blackColor]];
        [self addSubview:profileImage];
        
        indicator = [[UIActivityIndicatorView alloc] init];
        indicator.center = self.center;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        [self addSubview:indicator];
        
        // This adds self, which is the current class, as an observer for the image property of profileImage.
        [profileImage addObserver:self forKeyPath:@"image" options:0 context:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BLDownloadImageNotification"
                                                            object:self
                                                          userInfo:@{@"imageView":profileImage, @"profileImageURL":profileImageURL, @"cell":cell, @"index":[NSNumber numberWithInteger: index]}];
        
        [self bringSubviewToFront:profileImage];
        
        NSLog(@"Feed profile image view background color: %@, instance: %@\nSubviews: %@", self.backgroundColor, self, self.subviews);
        
    }
    return self;
}

- (void)dealloc
{
    [profileImage removeObserver:self forKeyPath:@"image"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"image"])
    {
        //[indicator stopAnimating];
    }
}


@end
