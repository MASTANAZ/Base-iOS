//
//  KeychainAPI.h
//  Base
//
//  Created by Blake Nazario on 8/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void (^CompleteKeychainMethod)(BOOL success, NSError *error);


@interface KeychainAPI : NSObject

@property (copy, nonatomic) CompleteKeychainMethod completeKeychainMethod;

+ (KeychainAPI*)sharedInstance;

/**
 Save an object to the keychain for a specified key.
 
 @param objects The array of objects that is to be saved.
 @param keys The keys for the saved objects; to be used as the key in the object-key pairs.
 
 @warning `objects` must not be `nil`
 @warning `keys` must not be `nil`
 **/
- (void)saveObjectsToKeychain:(NSArray*)objects
                      forKeys:(NSString*)keys
         withCompletionBlock:(void (^)(BOOL success, NSError *error))completionBlock;


/**
 Remove a specific object-key pair from the keychain. NOT IMPLEMENTED.
 
 @param key The key for the object-key pair that is to be removed.
 
 @warning `key` must not be `nil`.
 @warning This method is not implemented yet.
 **/
- (void)removeObjectFromKeychainForKey:(NSString*)key
                   withCompletionBlock:(void (^)(BOOL success, NSError *error))completionBlock;


/**
 Remove all object-key pairs from the keychain; should only be used when logging out.
 **/
- (void)removeAllObjectsAndKeysFromKeychainWithCompletionBlock:(void (^)(BOOL success, NSError *error))completionBlock;


@end
