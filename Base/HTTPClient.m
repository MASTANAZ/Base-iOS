//
//  HTTPClient.m
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "HTTPClient.h"

@implementation HTTPClient


+ (void)performGETrequestWithURL:(NSString*)urlString completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock
{
    
    // Execute all of the GET requests here;
    // Return whatever data is returned
    
    // Execute request
    
    // Perform completion block
}

+ (void)performPOSTrequestWithURL:(NSString *)url body:(NSString *)body
                  completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock
{
    // Execute all of the POST requests here;
    // Return whatever data is returned
    
}

- (UIImage*)downloadImage:(NSString*)url
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    return [UIImage imageWithData:data];
}

@end
