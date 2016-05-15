//
//  M_LandingZoneModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_LandingZoneModel.h"

@implementation M_LandingZoneModel

- (id)initWithMapObjectType:(NSString *)mapObjectType
                    station:(NSString *)station
    backgroundColorHexValue:(NSString *)backgroundColorHexValue
             boundingPoints:(NSArray *)boundingPoints
{
    self = [super init];
    
    if (self) {
        _mapObjectType = mapObjectType;
        _station = station;
        _backgroundColorHexValue = backgroundColorHexValue;
        _boundingPoints = boundingPoints;
        
    }
    return self;
}

@end
