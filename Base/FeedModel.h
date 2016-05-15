//
//  FeedModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedModel : NSObject

@property (strong, nonatomic, readonly) NSArray *feedItemsArray;

- (id)initWithFeedArray:(NSArray*)feedItemsArray;

@end
