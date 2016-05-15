//
//  TextPostModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextPostModel : NSObject

@property (strong, nonatomic, readonly) NSString *postType, *timestamp, *postBody;
@property (strong, nonatomic, readonly) NSDictionary *user;

- (id)initWithPostType:(NSString *)postType
                  user:(NSDictionary*)user
             timestamp:(NSString*)timestamp
              postBody:(NSString*)postBody;

@end
