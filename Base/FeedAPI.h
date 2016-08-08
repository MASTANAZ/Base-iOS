//
//  FeedAPI.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedAPI : NSObject

+ (FeedAPI*)sharedInstance;

/**
 Gets initial posts for the past date range
 **/
- (NSArray*)getPosts;

// This will be called by the Feed to simply retrieve the next posts; the Feed
// will not have to specify the date range for posts; this API will manage that.
- (NSArray*)getPostsForNextDateRange;


@end
