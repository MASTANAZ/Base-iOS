//
//  M_POIModel+M_POIModelTableRepresentation.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_POIModel+M_POIModelTableRepresentation.h"

@implementation M_POIModel (M_POIModelTableRepresentation)

- (NSDictionary*)m_poimtr_poiTableRepresentation {
    return @{
             @"MapObjectType":self.mapObjectType,
             @"POI Type":self.poiType,
             @"POI Info":self.poiInfo,
             @"Latitude":self.latitude,
             @"Longitude":self.longitude
             };
}

@end
