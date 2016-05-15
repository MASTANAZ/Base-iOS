//
//  M_POIModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_POIModel : NSObject

@property (strong, nonatomic, readonly) NSString *mapObjectType, *poiType, *poiInfo, *latitude, *longitude;

- (id)initWithMapObjectType:(NSString*)mapObjectType
                    poiType:(NSString*)poiType
                    poiInfo:(NSString*)poiInfo
                   latitude:(NSString*)latitude
                  longitude:(NSString*)longitude;

@end
