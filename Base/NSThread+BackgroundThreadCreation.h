//
//  NSThread+BackgroundThreadCreation.h
//  Base
//
//  Created by Blake Nazario on 7/6/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSThread (BackgroundThread)

/**
 Create a background thread to perform POST and GET requests.
 **/
+ (NSThread *)createThreadForRequests;

@end
