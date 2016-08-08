//
//  HTTP_GETRequestOperation.h
//  Base
//
//  Created by Blake Nazario on 7/6/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"

@protocol HTTP_GETRequestOperationDelegate;

@interface HTTP_GETRequestOperation : NSOperation {
    BOOL executing;
    BOOL finished;
}

/**
 The function that is called within the operation to complete the request.
 **/
- (void)completeGETRequest;

/**
 The HTTP GET request delegate
 **/
@property (nonatomic, weak) id<HTTP_GETRequestOperationDelegate> delegate;

@end



/** 
 HTTP_GETRequestOperationDelegate
 **/
 @protocol HTTP_GETRequestOperationDelegate <NSObject>

@required
- (void)receivedDataFromGETresponse:(NSData*)data
                         withErrors:(NSArray*)arrayOfErrors;

@end