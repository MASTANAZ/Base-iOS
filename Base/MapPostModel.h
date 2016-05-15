//
//  MapPostModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapPostModel : NSObject

@property (strong, nonatomic, readonly) NSString *postType, *latitude, *longitude, *address, *timestamp, *callType, *information, *responders, *isInProgress;
@property (strong, nonatomic, readonly) NSDictionary *user;


- (id)initWithPostType:(NSString *)postType
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
