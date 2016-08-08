//
//  KeychainAPI.m
//  Base
//
//  Created by Blake Nazario on 8/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "KeychainAPI.h"
#import "KeychainItemWrapper.h"

@implementation KeychainAPI

+ (KeychainAPI*)sharedInstance {
    // Static instance to ensure the class instance is available globally inside this class.
    static KeychainAPI *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[KeychainAPI alloc]init];
    });
    
    return _sharedInstance;
}


#pragma mark - API Methods

- (void)saveObjectsToKeychain:(NSArray*)objects
                      forKeys:(NSArray*)keys
          withCompletionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    
    self.completeKeychainMethod = completionBlock;
    
    NSLog(@"\n*** Storing user info in keychain");
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"BaseAppKeychainInformation" accessGroup:nil];

    NSError *error = nil;
    
    NSDictionary *dict = [[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    
    NSData *dictionaryRep = [NSPropertyListSerialization dataWithPropertyList:dict
                                                                       format:NSPropertyListXMLFormat_v1_0
                                                                      options: NSPropertyListWriteInvalidError
                                                                        error:&error];
    
    
    NSString *encodedString = [dictionaryRep base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [keychainItem setObject:encodedString forKey:(__bridge id)kSecValueData];
    
    
    // Now, check to make sure the value saved
    
    for (int idx = 0; idx < objects.count; idx++) {
        [self checkKeychainForObject:[objects objectAtIndex:idx] withKey:[keys objectAtIndex:idx] withCompletionBlock:^(BOOL objectsAndKeysExist)
        {
            // Error encountered
            if (!objectsAndKeysExist) {
                if (self.completeKeychainMethod) {
#warning Use actual NSError in this completion block.
                    self.completeKeychainMethod(NO, nil);
                }
            }
        }];
    }
    
    // Assume block finished
    if (self.completeKeychainMethod) {
        self.completeKeychainMethod(YES, nil);
    }
    
    ////  How to decrypt the keychain:
    //
    //    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString: [keychainItem objectForKey:(__bridge id)kSecValueData]
    //                                                              options:NSDataBase64DecodingIgnoreUnknownCharacters];
    //
    //    NSDictionary *newDict = [NSPropertyListSerialization propertyListWithData:decodedData
    //                                                                      options:NSPropertyListReadCorruptError
    //                                                                       format:0
    //                                                                        error:&error];
    //
    //    NSLog(@"\n\n*** \n\nEncrypted User Information: \n\n%@\n\n***\n\n", [keychainItem objectForKey:(__bridge id)kSecValueData]);
    //    NSLog(@"\n\n***\n\nDecrypted User Information: \n\n%@\n\n", newDict);
}

- (void)removeObjectFromKeychainForKey:(NSString *)key
                   withCompletionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    // 1) Delete object-key pair from keychain
    
    
    // 2) Make sure object-key pair is removed
}

- (void)removeAllObjectsAndKeysFromKeychainWithCompletionBlock:(void (^)(BOOL, NSError *))completionBlock
{
 
    NSArray *secItemClasses = @[(__bridge id)kSecClassGenericPassword,
                                (__bridge id)kSecClassInternetPassword,
                                (__bridge id)kSecClassCertificate,
                                (__bridge id)kSecClassKey,
                                (__bridge id)kSecClassIdentity];
    for (id secItemClass in secItemClasses) {
        NSDictionary *spec = @{(__bridge id)kSecClass: secItemClass};
        SecItemDelete((__bridge CFDictionaryRef)spec);
    }

    
    // Check to make sure all items are deleted
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"BaseAppKeychainInformation" accessGroup:nil];
    
    // Keychain has no data
    if ([[keychainItem objectForKey:(__bridge id)(kSecValueData)] isEqualToString:@""]) {
        // no value
        NSLog(@"KEYCHAIN USER DATA IS NIL");

        completionBlock(YES, nil);
        
    }
    
    else {
#warning Use actual NSError for this completion block
        completionBlock(NO, nil);
    }
}


#pragma mark - Helper Methods

- (void)checkKeychainForObject:(id)object
                       withKey:(NSString*)key
            withCompletionBlock:(void (^)(BOOL objectsAndKeysExist))completionBlock
{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithIdentifier:@"BaseAppKeychainInformation" accessGroup:nil];
    
    // Keychain has no data
    if ([[keychainItem objectForKey:(__bridge id)(kSecValueData)] isEqualToString:@""]) {
        // no value
        NSLog(@"KEYCHAIN USER DATA IS NIL");

        completionBlock(NO);
        
    }
    
    else {
        // existing value
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString: [keychainItem objectForKey:(__bridge id)kSecValueData]
                                                                  options:NSDataBase64DecodingIgnoreUnknownCharacters];
        
        NSDictionary *keychainDict = [NSPropertyListSerialization propertyListWithData:decodedData
                                                                          options:NSPropertyListReadCorruptError
                                                                           format:0
                                                                            error:nil];
        
        
        //        NSLog(@"KEYCHAIN USER DATA IS: %@", newDict);
        
        if (keychainDict != nil || keychainDict != NULL) {
            
            // Check if requested key exists
            if ([[keychainDict allKeys] containsObject: key]) {
                
                // Check to see if the object exists;
                // if YES: Complete with no erros
                // else: Throw exception
                if ([[keychainDict objectForKey:key] isEqual:object]) {
                    completionBlock(YES);
                }
                
                else {
                    completionBlock(NO);
                }
            }
            
            // Key does not exist
            else {
                completionBlock(NO);
            }
            
        }
        
        // Keychain actually has no tangible data
        else {
            // NO data actually exists
            completionBlock(NO);
            
        }
    }
}

@end
