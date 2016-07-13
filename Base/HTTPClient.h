//
//  HTTPClient.h
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Used to dynamically create and remove background queues for execution of requests.
#import "NSOperationQueue+GenerateBackgroundQueue.h"

// Server IP/URL address to be accessed in the API
#define serverAddress @"http://server.com"

// The HTTP_GETRequest Operation
#import "HTTP_GETRequestOperation.h"

@protocol HTTP_GETRequestOperationDelegate;

typedef void (^CompleteGETRequest)(BOOL success, NSData *responseData, NSError *error);
typedef void (^CompletePOSTRequest)(BOOL success, NSData *responseData, NSError *error);

@interface HTTPClient : NSObject <HTTP_GETRequestOperationDelegate>


@property (copy, nonatomic) CompleteGETRequest completeGetRequest;
@property (copy, nonatomic) CompletePOSTRequest completePostRequest;

+ (void)performGETrequestWithURL:(NSString*)urlString
               completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock; // CompleteGetRequest

+ (void)performPOSTrequestWithURL:(NSString*)urlString body:(NSString*)body
                completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock; // CompletePostRequest


/**
 Download an image from a specfied URL that directly links to an image.
 
 @param url The URL that the image will be downloaded from in the form of an NSString.
 
 @warning `url` must not be `nil`.
 **/
- (UIImage*)downloadImage:(NSString*)url;

@end
