//
//  MapPersistencyManager.h
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MapModel.h"
#import "M_PreviousCallModel.h"
#import "M_LandingZoneModel.h"
#import "M_HydrantModel.h"
#import "M_POIModel.h"

@interface MapPersistencyManager : NSObject

- (NSArray*)getMapObjects;

@end
