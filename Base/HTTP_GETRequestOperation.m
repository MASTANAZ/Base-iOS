//
//  HTTP_GETRequestOperation.m
//  Base
//
//  Created by Blake Nazario on 7/6/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "HTTP_GETRequestOperation.h"

@implementation HTTP_GETRequestOperation

- (id)init {
    self = [super init];
    if (self) {
        executing = NO;
        finished = NO;
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}


#pragma mark - NSOperation Methods

- (void)main {
    @try {
        // Do main work of the operation here
        
        // Complete the GET request
        [self completeGETRequest];
    }
    
    @catch(NSException *exception) {
        // Do not rethrow exceptions.
    }
}

- (void)start {
    // Always check for cancellation before launching the task.
    if ([self isCancelled])
    {
        // Must move the operation to the finished state if it is canceled.
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If the operation is not canceled, begin executing the task.
    [self willChangeValueForKey:@"isExecuting"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}


#pragma mark - Custom Methods

- (void)completeGETRequest {
    NSLog(@"Completing GET Request!");
    
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    
    
    // 1) Create URL
    NSURL *serverURL = [NSURL URLWithString:serverAddress];
    
    
    // 2) Create background Queue to perform actions in.
    NSOperationQueue *getRequestQueue = [NSOperationQueue createBackgroundQueueForRequests];
    
    // 3) Create Session
    NSURLSession *getRequestSession = [[NSURLSession alloc] init];
    
    // 4) Perform data task in backgroun Queue
    
//    dispatch_group_t getRequestGroup = dispatch_group_create();
//    dispatch_group_enter(getRequestGroup);
    
    [getRequestQueue addOperationWithBlock:^{
    
        [getRequestSession dataTaskWithRequest:[NSURLRequest requestWithURL:serverURL]
                             completionHandler:^(NSData * _Nullable data,
                                                 NSURLResponse * _Nullable response,
                                                 NSError * _Nullable error)
         {
             // Error actually executing the request
             if (error )
             {
                 // Return Data here,
                 if (self.delegate && [self.delegate respondsToSelector:@selector(receivedDataFromGETresponse:withErrors:)])
                 {
                     [self.delegate receivedDataFromGETresponse:data
                                                     withErrors:@[[NSError errorWithDomain:@"HTTPGetRequestError"
                                                                                      code: error.code
                                                                                  userInfo:@{NSLocalizedDescriptionKey:error.description,
                                                                                             NSLocalizedRecoverySuggestionErrorKey:error.localizedRecoverySuggestion,
                                                                                             NSLocalizedFailureReasonErrorKey:error.localizedFailureReason}]]
                      ];
                 }
                 
                 dispatch_group_leave(getRequestGroup);
             }
             
             // No errors executing the request
             else {
                 // Return Data here,
                 if (self.delegate && [self.delegate respondsToSelector:@selector(receivedDataFromGETresponse:withErrors:)])
                 {
                     [self.delegate receivedDataFromGETresponse:data
                                                     withErrors:nil];
                 }
                 
//                 dispatch_group_leave(getRequestGroup);
             }
             
             
             
             executing = NO;
             finished = YES;
         }];
    }];


    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}


@end
