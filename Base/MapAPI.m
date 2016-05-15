//
//  MapAPI.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MapAPI.h"
#import "HTTPClient.h"
#import "MapPersistencyManager.h"

@interface MapAPI () {
    MapPersistencyManager *persistencyManager;
    HTTPClient *httpClient;
    
    BOOL isOnline;
}

@end

@implementation MapAPI

+ (MapAPI*)sharedInstance {
    
    static MapAPI *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[MapAPI alloc]init];
    });
    
    return _sharedInstance;
}

- (id)init {
    self = [super init];

    if (self) {
        persistencyManager = [[MapPersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        
        isOnline = NO;
        
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(downloadMapObjects:) name:@"DownloadMapObjectsNotification" object:nil];
    }
    
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray*)getMapObjects {
    return [persistencyManager getMapObjects];
}

- (void)downloadMapObjects:(NSNotification*)notification {
    
    
}



@end
