//
//  M_LandingZoneModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_LandingZoneModel : NSObject

@property (strong, nonatomic, readonly) NSString *mapObjectType, *station, *backgroundColorHexValue;
@property (strong, nonatomic, readonly) NSArray *boundingPoints;

- (id)initWithMapObjectType:(NSString*)mapObjectType
                    station:(NSString*)station
    backgroundColorHexValue:(NSString*)backgroundColorHexValue
             boundingPoints:(NSArray*)boundingPoints;

@end
