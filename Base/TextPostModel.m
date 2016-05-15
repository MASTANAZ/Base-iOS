//
//  TextPostModel.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "TextPostModel.h"

@implementation TextPostModel

- (id)initWithPostType:(NSString *)postType
                  user:(NSDictionary *)user
             timestamp:(NSString *)timestamp
              postBody:(NSString *)postBody
{
    self = [super init];
    
    if (self) {
        _postType = postType;
        _user = user;
        _timestamp = timestamp;
        _postBody = postBody;
    }
    
    return self;
}

@end
