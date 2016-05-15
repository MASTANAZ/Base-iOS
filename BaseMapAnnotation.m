//
//  BaseMapAnnotation.m
//  Base
//
//  Created by Blake Nazario on 2/10/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "BaseMapAnnotation.h"

@implementation BaseMapAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;


- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    
    if (self != nil) {
        self.coordinate = coordinate;
    }
    
    return self;
}

- (NSString *)title {
    return _title;
}

- (NSString *)subtitle {
    return _subtitle;
}

@end
