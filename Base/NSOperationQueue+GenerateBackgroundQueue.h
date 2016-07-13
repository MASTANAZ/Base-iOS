//
//  NSOperationQueue+GenerateBackgroundQueue.h
//  Base
//
//  Created by Blake Nazario on 7/6/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperationQueue (BackgroundQueue)

/**
 Create a background queue to perform POST and GET requests.
 **/
+ (NSOperationQueue *)createBackgroundQueueForRequests;

@end
