//
//  M_LandingZoneModel+M_LandingZoneModelTableRepresentation.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_LandingZoneModel+M_LandingZoneModelTableRepresentation.h"

@implementation M_LandingZoneModel (M_LandingZoneModelTableRepresentation)

- (NSDictionary*)m_lzmtr_landingZoneTableRepresentation {
    return @{
             @"MapObjectType":self.mapObjectType,
             @"Station":self.station,
             @"BackgroundColorHexValue":self.backgroundColorHexValue,
             @"BoundingPoints":self.boundingPoints             
             };
}

@end
