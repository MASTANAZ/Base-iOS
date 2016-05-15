//
//  HTTPClient.h
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CompleteGETRequest)(BOOL success, NSData *responseData, NSError *error);

@interface HTTPClient : NSObject


@property (copy, nonatomic) CompleteGETRequest completeGetRequest;


+ (void)performGETrequestWithURL:(NSString*)urlString
               completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock;

+ (void)performPOSTrequestWithURL:(NSString*)urlString body:(NSString*)body
                completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock;

- (UIImage*)downloadImage:(NSString*)url;

@end
