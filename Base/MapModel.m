//
//  MapModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MapModel.h"

@implementation MapModel

- (id)initWithMapObjectsArray:(NSArray *)mapObjectsArray {
    self = [super init];
    
    if (self) {
        _mapObjectsArray = mapObjectsArray;
    }
    
    return self;
}

@end
