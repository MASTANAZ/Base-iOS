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

@interface HTTP_POSTRequestOperation : NSOperation {
    BOOL executing;
    BOOL finished;
}

/**
 The function that is called within the operation to complete the POST request.
 **/
- (void)completePOSTRequestWithURL:(NSString *)url;

@property (nonatomic, weak) id<HTTP_POSTRequestOperationDelegate> delegate;

@end


/**
 HTTP_POSTRequestOperationDelegate
 **/
@protocol HTTP_POSTRequestOperationDelegate <NSObject>

@required
- (void)receivedDataFromPOSTresponse:(NSData*)data
                          withErrors:(NSArray*)arrayOfErrors;

@end
