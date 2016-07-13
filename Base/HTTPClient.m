//
//  HTTPClient.m
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient


+ (void)performGETrequestWithURL:(NSString*)urlString
                 completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock
{
    
    // Execute all of the GET requests here;
    // Return whatever data is returned
    
    // 1) Create Operation
    HTTP_GETRequestOperation *getOperation = [[HTTP_GETRequestOperation alloc]init];
    
    [getOperation start];
    
    //TODO: Use KVO to find what the Delegate response is.
}

+ (void)performPOSTrequestWithURL:(NSString *)url
                             body:(NSString *)body
                  completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock
{
    // Execute all of the POST requests here;
    // Return whatever data is returned
    
}


#pragma mark - Specific Actions

- (UIImage*)downloadImage:(NSString*)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:data];
}


#pragma mark - HTTP GET Request Delegate
//TODO: Add KVO Functionality here to know when the completion block for the API is able to be called.
- (void)receivedDataFromGETresponse:(NSData *)data
                         withErrors:(NSArray *)arrayOfErrors
{
    // Handle Errors
    if (arrayOfErrors != nil) {
    
    }
    
    // Do what needs to be done using KVO
    else {
        
    }
}
@end
