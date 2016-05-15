//
//  M_PreviousCallModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_PreviousCallModel : NSObject

@property (strong, nonatomic, readonly) NSString *mapObjectType, *latitude, *longitude, *address, *timestamp, *callType, *information, *responders, *isInProgress;

@property (strong, nonatomic, readonly) NSDictionary *user;

- (id)initWithMapObjectTypeType:(NSString *)mapObjectType
                           user:(NSDictionary*)user
                       latitude:(NSString*)latitude
                      longitude:(NSString*)longitude
                        address:(NSString*)address
                      timestamp:(NSString*)timestamp
                       callType:(NSString*)callType
                    information:(NSString*)information
                     responders:(NSString*)responders
                     inProgress:(NSString*)isInProgress;

@end
