//
//  M_HydrantModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_HydrantModel.h"

@implementation M_HydrantModel

#warning This may change depending on the parameters of the hydrants from the county database.
- (id)initWithMapObjectType:(NSString *)mapObjectType
                  hydrantID:(NSString *)hydrantID
                   latitude:(NSString *)latitude
                  longitude:(NSString *)longitude
{
    self = [super init];
    
    if (self) {
        _mapObjectType = mapObjectType;
        _hydrantID = hydrantID;
        _latitude = latitude;
        _longitude = longitude;
    }
    
    return self;
}

@end
