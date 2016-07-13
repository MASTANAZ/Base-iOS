//
//  NSOperationQueue+GenerateBackgroundQueue.m
//  Base
//
//  Created by Blake Nazario on 7/6/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "NSOperationQueue+GenerateBackgroundQueue.h"

@implementation NSOperationQueue (BackgroundQueue)

+ (NSOperationQueue *)createBackgroundQueueForRequests {
    
    NSOperationQueue *backgroundQueue = [[NSOperationQueue alloc]init];
    
    return backgroundQueue;
}

@end
