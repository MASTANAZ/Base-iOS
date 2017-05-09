//
//  HTTP_GETRequestOperation.h
//  Base
//
//  Created by Blake Nazario on 7/6/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HTTP_GETRequestOperationDelegate;

/**
 HTTP_GETRequestOperationDelegate
 **/
@protocol HTTP_GETRequestOperationDelegate <NSObject>

@required
- (void)receivedDataFromGETresponse:(NSData*)data
                         withErrors:(NSArray*)arrayOfErrors;

@end


#import "HTTPClient.h"


@interface HTTP_GETRequestOperation : NSOperation {
    BOOL executing;
    BOOL finished;
}

/**
 The function that is called within the operation to complete the request.
 **/
- (void)completeGETRequestWithURL:(NSString*)url;

/**
 Custom start method that begins operation with specified URL
 
 @param url The URL that the image will be used for the GET operation
 
 @warning `url` must not be `nil`.
 **/
- (void)startWithURL:(NSString*)url;

/**
 The HTTP GET request delegate
 **/
@property (nonatomic, weak) id<HTTP_GETRequestOperationDelegate> delegate;

@end



