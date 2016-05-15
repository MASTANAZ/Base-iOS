//
//  M_HydrantModel+M_HydrantModelTableRepresentation.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_HydrantModel+M_HydrantModelTableRepresentation.h"

@implementation M_HydrantModel (M_HydrantModelTableRepresentation)

- (NSDictionary*)m_hmtr_hydrantTableRepresentation {
    return @{
             @"MapObjectType":self.mapObjectType,
             @"HydrantID":self.hydrantID,
             @"Latitude":self.latitude,
             @"Longitude":self.longitude
             };
}

@end
