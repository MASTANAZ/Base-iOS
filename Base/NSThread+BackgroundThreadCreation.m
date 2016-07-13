//
//  NSThread+BackgroundThreadCreation.m
//  Base
//
//  Created by Blake Nazario on 7/6/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "NSObject+BackgroundThreadCreation.h"

@implementation NSThread (BackgroundThread)

+ (NSThread *)createThreadForRequests {
    
    
    return [NSThread mainThread];
}

@end
