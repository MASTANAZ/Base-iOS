//
//  HTTPClient.m
//  MyLibrary
//
//  Created by Eli Ganem on 8/7/13.
//  Copyright (c) 2013 Eli Ganem. All rights reserved.
//

#import "HTTPClient.h"


@implementation HTTPClient

+ (HTTPClient*)sharedInstance {
    
    static HTTPClient *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[HTTPClient alloc]init];
    });
    
    return _sharedInstance;
}

- (void)performGETrequestWithURL:(NSString*)urlString
                 completionBlock:(void (^)(BOOL, NSData *, NSError *))completionBlock
{
    
    
    HTTPClient *client = [HTTPClient sharedInstance];
    client.completeGetRequest = completionBlock;
    
    
////    // Execute all of the GET requests here;
////    // Return whatever data is returned
//    
//    // 1) Create Operation
//    HTTP_GETRequestOperation *getOperation = [[HTTP_GETRequestOperation alloc]init];
//    getOperation.delegate = self;
//    
//    [getOperation startWithURL:urlString];
////
////    //TODO: Use KVO to find what the Delegate response is.
    
    
    // 1) Create URL
    NSURL *serverURL = [NSURL URLWithString:urlString];    // serverAddress];
    
    // 2) Create background Queue to perform actions in.
    NSOperationQueue *getRequestQueue = [NSOperationQueue createBackgroundQueueForRequests];
    
    // 3) Create Session
    NSURLSession *getRequestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    
    // 4) Perform data task in backgroun Queue
    
    dispatch_group_t getRequestGroup = dispatch_group_create();
    dispatch_group_enter(getRequestGroup);
    
    [getRequestQueue addOperationWithBlock:^{
        
        NSURLSessionDataTask *task = [getRequestSession dataTaskWithRequest:[NSURLRequest requestWithURL:serverURL]
                                                          completionHandler:^(NSData * _Nullable data,
                                                                              NSURLResponse * _Nullable response,
                                                                              NSError * _Nullable error)
                                      {
                                          // Error actually executing the request
                                          if (error )
                                          {
                                              
                                              dispatch_group_leave(getRequestGroup);
                                          }
                                          
                                          // No errors executing the request
                                          else {
                                              
                                              NSLog(@"DATAA: %@", data);
                                              NSLog(@"RESPONSE: %@", response);
                                              
                                              client.completeGetRequest(YES, data, nil);
                                              
                                              // Return Data here,
                                              
                                              dispatch_group_leave(getRequestGroup);
                                          }
                                          
                                          
                                          
                                          //             executing = NO;
                                          //             finished = YES;
                                      }];
        
        [task resume];
        
        dispatch_group_notify(getRequestGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{

        });
        
        
    }];

    
}

- (void)performPOSTrequestWithURL:(NSString *)url
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
    
    NSLog(@"DELEGATE");
    // Handle Errors
    if (arrayOfErrors != nil) {
    
    }
    
    // Do what needs to be done using KVO
    else {
        [self willChangeValueForKey:@"Test"];
        
        NSLog(@"Data: %@", data);
    }
}
@end
