//
//  FeedModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "FeedModel.h"

@implementation FeedModel

- (id)initWithFeedArray:(NSArray *)feedItemsArray {
    self = [super init];
    
    if (self) {
        _feedItemsArray = feedItemsArray;
    }
    
    return self;
}

@end
