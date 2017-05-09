//
//  HTTP_POSTRequestOperation.h
//  Base
//
//  Created by Blake Nazario on 8/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HTTPClient.h"

@protocol HTTP_POSTRequestOperationDelegate;

/**
 HTTP_POSTRequestOperationDelegate
 **/
@protocol HTTP_POSTRequestOperationDelegate <NSObject>

@required
- (void)receivedDataFromPOSTresponse:(NSData*)data
                          withErrors:(NSArray*)arrayOfErrors;

@end

@interface HTTP_POSTRequestOperation : NSOperation {
    BOOL executing;
    BOOL finished;
}

/**
 The function that is called within the operation to complete the POST request.
 
 @param url The URL that the image will be used for the GET operation
 
 @warning `url` must not be `nil`.
 **/
- (void)completePOSTRequestWithURL:(NSString *)url;

@property (nonatomic, weak) id<HTTP_POSTRequestOperationDelegate> delegate;

@end



