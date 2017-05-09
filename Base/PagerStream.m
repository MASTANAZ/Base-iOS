//
//  PagerStream.m
//  Base
//
//  Created by Blake Nazario on 5/8/17.
//  Copyright © 2017 Kudoko, LLC. All rights reserved.
//

#import "PagerStream.h"

@implementation PagerStream

- (id)initWithURL:(NSURL *)URL {
    self = [super init];
    
    if (self != nil) {
        streamURL = URL;
    }
    
    
    return self;
}



@end
