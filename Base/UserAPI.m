//
//  UserAPI.m
//  Base
//
//  Created by Blake Nazario on 8/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "UserAPI.h"
#import "HTTPClient.h"
#import "NSUserDefaultsAPI.h"
#import "KeychainAPI.h"

@interface UserAPI () {
    HTTPClient *httpClient;
}

@end


@implementation UserAPI

+ (UserAPI*)sharedInstance {
    // 1) Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
    static UserAPI *_sharedInstance = nil;
    
    // 2) Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of LibraryAPI.
    // This is the essence of the Singleton design pattern: the initializer is never called again once the class has been instantiated.
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[UserAPI alloc]init];
    });
    
    return _sharedInstance;
}

// Implement completion block, use that in calling class to show login screen
- (void)logoutUserWithCompletionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    self.completeLogout = completionBlock;
    
    // 1) Clear NSUserDefaults
    NSUserDefaultsAPI *defaultsAPI = [NSUserDefaultsAPI sharedInstance];
    [defaultsAPI removeAllUserDefaults];
    
    // 2) Clear Keychain
    KeychainAPI *keychainAPI = [KeychainAPI sharedInstance];
    [keychainAPI removeAllObjectsAndKeysFromKeychainWithCompletionBlock:^(BOOL success, NSError *error)
    {
        if (success) {
            if (self.completeLogout) {
                self.completeLogout(YES, nil);
            }
        }
        
#warning Use actual NSError for this 
        else {
            self.completeLogout(NO, nil);
        }
    }];
    
    // 3) When finished, show Login screen via NSNotification
    
    
}

@end
