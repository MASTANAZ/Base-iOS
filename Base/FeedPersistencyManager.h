//
//  FeedPersistencyManager.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "FeedModel.h"
#import "MapPostModel.h"
#import "TextPostModel.h"

@interface FeedPersistencyManager : NSObject {
    
    // These will be used to calculate the range of dates to call to teh server
    // for posts.
    NSDateFormatter *dateRangeFormatter;
    NSString *currentPostDaterange;
    
    // This is the number of days that exist in the date range
    NSInteger numberOfDaysForDateRange;
}

/**
 Gets initial posts for the past date range
 **/
- (NSArray*)getPosts;

// This will be called by the Feed to simply retrieve the next posts; the Feed
// will not have to specify the date range for posts; this API will manage that.
- (NSArray*)getPostsForNextDateRange;

/**
 Saves the image to the /Documents/~filename~ directory.
 
 @param filename The filename that the image will be saved as.
 
 @warning `filename` must not be `nil`.
 **/
- (void)saveImage:(UIImage*)image filename:(NSString*)filename;

/**
 Retrieves image from the /Documents/~filename~ directory.
 
 @param filename The filename of the image to be retreived.
 
 @warning `filename` must not be `nil`.
 **/
- (UIImage*)getImage:(NSString*)filename;

@end
