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
typedef void (^CompletePOSTRequest)(BOOL success, NSData *responseData, NSError *error);

@interface HTTPClient : NSObject


@property (copy, nonatomic) CompleteGETRequest completeGetRequest;
@property (copy, nonatomic) CompletePOSTRequest completePostRequest;

+ (void)performGETrequestWithURL:(NSString*)urlString
               completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock; // completeGetRequest

+ (void)performPOSTrequestWithURL:(NSString*)urlString body:(NSString*)body
                completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock; // CompletePostRequest

/**
 Download an image from a specfied URL that directly links to an image.
 
 @param url The URL that the image will be downloaded from in the form of an NSString.
 
 @warning `url` must not be `nil`.
 **/
- (UIImage*)downloadImage:(NSString*)url;

@end
