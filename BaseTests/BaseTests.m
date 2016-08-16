//
//  BaseTests.m
//  BaseTests
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

// HTTP GET Request
#import "HTTP_GETRequestOperation.h"

#import "HTTPClient.h"

@interface BaseTests : XCTestCase <HTTP_GETRequestOperationDelegate> {
    XCTestExpectation *serverRespondExpectation;
}

@end

@implementation BaseTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


/**
 Testing for HTTP GET Request Execution & Delegate Response
 */
- (void)testHTTP_GETRequestExecution {
    HTTP_GETRequestOperation *getOperation = [[HTTP_GETRequestOperation alloc]init];
    getOperation.delegate = self;

    [getOperation startWithURL:@"http://52.43.181.189:5000/"];
    
    serverRespondExpectation = [self expectationWithDescription:@"server responded"];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTAssert(NO, @"Error in request delegate?");
        }
    }];
    
    if ([getOperation isExecuting]) {
        //No teardown needed
        NSLog(@"HTTP GET Request Operation is executing.");
    }
    
//    else {
//        XCTAssert(NO, @"HTTP GET Request Operation is failing to execut.");
//    }
}

- (void)testHTTPClientGET {
    serverRespondExpectation = [self expectationWithDescription:@"server responded"];

    HTTPClient *client = [HTTPClient sharedInstance];
    
    [client performGETrequestWithURL:@"http://52.43.181.189:5000"
                         completionBlock:^(BOOL success, NSData *data, NSError *error) {
                             NSLog(@"Success");
                             XCTAssert(YES, @"Completion Block executed successfully");
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError * _Nullable error) {
        if (error) {
            XCTAssert(NO, @"Error in request delegate?");
        }
    }];
}

/**
 Delegate method for HTTP Get Request
 */
- (void)receivedDataFromGETresponse:(NSData *)data withErrors:(NSArray *)arrayOfErrors{
    NSLog(@"Delegate");
    [serverRespondExpectation fulfill];
    
    if (arrayOfErrors != nil) {
        XCTAssert(NO, @"HTTP Response error");
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
