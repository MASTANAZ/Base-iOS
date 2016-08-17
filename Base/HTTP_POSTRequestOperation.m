//
//  HTTP_POSTRequestOperation.m
//  Base
//
//  Created by Blake Nazario on 8/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "HTTP_POSTRequestOperation.h"

@implementation HTTP_POSTRequestOperation

NSString *currentPOSTURL;
NSString *currentPOSTBody;

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
    
    [super main];
    
    @try {
        // Do the main work of the operation here
        
        [self completePOSTRequestWithURL:currentPOSTURL];
    }
    
    @catch (NSException *exception) {
        // Do not rethrow exceptions
    }
}

- (void)startWithURL:(NSString*)url andBody:(NSString *)body {
    
    currentPOSTURL = url;
    currentPOSTBody = body;
    
    [super start];
    
    // Always check for cancellation before launching the task.
    if ([self isCancelled]) {
        // Must move operation to the finished state if it is cancelled
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    // If th eoperation is not cancelled, begin executing the task
    [self willChangeValueForKey:@"isFinished"];
    [NSThread detachNewThreadSelector:@selector(main) toTarget:self withObject:nil];
    executing = YES;
    [self didChangeValueForKey:@"isExecuting"];
}

#pragma mark - Custom Methods

- (void)completePOSTRequestWithURL:(NSString *)url {
    NSLog(@"Completing GET Request!");
    
    //    [self willChangeValueForKey:@"isFinished"];
    //    [self willChangeValueForKey:@"isExecuting"];
    
    // 1) Create URL
    NSURL *serverURL = [NSURL URLWithString:url];    // serverAddress];
    
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
                 // Return Data here,
                 if (self.delegate && [self.delegate respondsToSelector:@selector(receivedDataFromPOSTresponse:withErrors:)])
                 {
                     [self.delegate receivedDataFromPOSTresponse:data
                                                     withErrors:@[[NSError errorWithDomain:@"HTTPPostRequestError"
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
                 if (self.delegate && [self.delegate respondsToSelector:@selector(receivedDataFromPOSTresponse:withErrors:)])
                 {
                     [self.delegate receivedDataFromPOSTresponse:data
                                                     withErrors:nil];
                 }
                 
                 dispatch_group_leave(getRequestGroup);
             }

             //             executing = NO;
             //             finished = YES;
         }];
        
        [task resume];
        
        dispatch_group_notify(getRequestGroup, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            [self willChangeValueForKey:@"isFinished"];
            [self willChangeValueForKey:@"isExecuting"];
            
            executing = NO;
            finished = YES;
            
            [self didChangeValueForKey:@"isExecuting"];
            [self didChangeValueForKey:@"isFinished"];
        });
        
        
    }];
    
    
    [self didChangeValueForKey:@"isExecuting"];
    [self didChangeValueForKey:@"isFinished"];
}

@end
