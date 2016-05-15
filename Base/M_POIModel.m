//
//  M_POIModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_POIModel.h"

@implementation M_POIModel

- (id)initWithMapObjectType:(NSString *)mapObjectType
                    poiType:(NSString *)poiType
                    poiInfo:(NSString *)poiInfo
                   latitude:(NSString *)latitude
                  longitude:(NSString *)longitude
{
    self = [super init];
    
    if (self) {
        _mapObjectType = mapObjectType;
        _poiType = poiType;
        _poiInfo = poiInfo;
        _latitude = latitude;
        _longitude = longitude;
    }
    
    
    return self;
}

@end
