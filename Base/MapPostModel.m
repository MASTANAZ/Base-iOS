//
//  MapPostModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MapPostModel.h"

@implementation MapPostModel

- (id)initWithPostType:(NSString *)postType
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
        _postType = postType;
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
