//
//  M_PreviousCallModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_PreviousCallModel.h"

@implementation M_PreviousCallModel

- (id)initWithMapObjectTypeType:(NSString *)mapObjectType
                           user:(NSDictionary *)user
                       latitude:(NSString *)latitude
                      longitude:(NSString *)longitude
                        address:(NSString *)address
                      timestamp:(NSString *)timestamp
                       callType:(NSString *)callType
                    information:(NSString *)information
                     responders:(NSString *)responders
                     inProgress:(NSString *)isInProgress

{
    
    self = [super init];
    
    if (self){
        _mapObjectType = mapObjectType;
        _user = user;
        _latitude = latitude;
        _longitude = longitude;
        _address = address;
        _timestamp = timestamp;
        _callType = callType;
        _information = information;
        _responders = responders;
        _isInProgress = isInProgress;
    }
    
    return self;
}

@end
