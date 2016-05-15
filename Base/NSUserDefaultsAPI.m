//
//  NSUserDefaultsAPI.m
//  Base
//
//  Created by Blake Nazario on 5/4/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "NSUserDefaultsAPI.h"



// Put the user defaults data structure/format here.


/* NSError Codes for UserDefaults domain
 
 -100 to -199: Error retrieving Defaults/ data for Defaults.
 --------------------------------------------------------------------------
    -100: Unable to get keys for Defaults
 
 
 -200 to -299: Error setting object for Defaults key
 --------------------------------------------------------------------------
    -200: Attempt to write Object to defaults that is not of valid object type
    -201: Attempt to add duplicate object for specified Key in defaults
    -202: Failed to add new Object-Key pair to Defautls
    -203: Unable to save First Name to User Defaults
    -204: Unable to save Last Name to User Defaults
    -205: Unable to save Base Name to User Defaults
    -206: Unable to save Profile Image to User Defaults
 
 
 */

@interface NSUserDefaultsAPI () {
    NSUserDefaults *userDefaults;
    NSArray *definedConstantKeysArray;  // Used to see if the key exists
}

@end

@implementation NSUserDefaultsAPI

+ (NSUserDefaultsAPI*)sharedInstance {
    
    // Static instance to ensure the class instance is available globally inside this class.
    static NSUserDefaultsAPI *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[NSUserDefaultsAPI alloc]init];
    });
    
    return _sharedInstance;
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        userDefaults = [NSUserDefaults standardUserDefaults];
        
#warning - If Adding new constants for the defaults, be sure to reflect them here as well.
        definedConstantKeysArray = @[kFirstNameDefaultsKey, kLastNameDefaultsKey, kProfileImageDefaultsKey];
    }
    
    return self;
}


// API Persistency
- (void)getUserDefaultsKeysWithCompletionBlock:(void (^)(BOOL, NSArray *, NSError *))completionBlock {
    
    self.completeKeysForDefaults = completionBlock;
    
    NSArray *defaultsKeys = [NSArray arrayWithArray:[[userDefaults dictionaryRepresentation]allKeys]];
    
    if (defaultsKeys) {
        if (self.completeKeysForDefaults) {
            self.completeKeysForDefaults(YES, defaultsKeys, nil);
        }
    }
    
    else {
        
        NSDictionary *errorDetails = [NSMutableDictionary dictionary];
        [errorDetails setValue:@"Could not return keys for User Defaults" forKey:NSLocalizedDescriptionKey];
        
        NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-100 userInfo:errorDetails];
        
        if (self.completeKeysForDefaults) {
            self.completeKeysForDefaults(NO, nil, error);
        }
    }
}


// API Methods
// Deprecated
- (void)syncDefaultsWithCompletionBlock:(void (^)(BOOL, NSError *))completionBlock {
//    BOOL synchronized = [userDefaults synchronize];
}

//TODO: Add a check here to see if the key is a predefiend key.
- (void)setDefaultsObject:(id)object forKey:(NSString *)key
          completionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    
    self.completeDefaultsAPI = completionBlock;
    
    // Object attempting to be written is of a valid object type for User Defaults
    if ([self objectForDefaultsKeyIsValid: object]) {
    
        // Attempting to set an object for something that already exists, or a predefined key.
        if ([definedConstantKeysArray containsObject:key]) {
            
            // Create dict for details
            NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
            
            [errorDetail setObject:[NSString stringWithFormat:@"Attempt to add duplicate object for Key: \"%@\"; in Defaults.", key]
                            forKey:NSLocalizedDescriptionKey];
            
            [errorDetail setObject:@"To prevent incorrect or accidental overwriting of predefined Object-Key pair, this error has been triggered."
                            forKey:NSLocalizedFailureReasonErrorKey];
            
            [errorDetail setObject:@"If attempting to add/set/overwrite an object for First/Last Name or a Profile Image, use the predefined methods in this API. If attempting to overwrite a non-default Object-Key pair that you defined somewhere else in code, add a method to this API to do so and include the Key in BaseUserDefaultsConstants.h. Be sure to also add the key to the array of ConstantKeys in the init method of this API.; If attempting to create a new Object-Key, use a different Key name as the Key attempting to be used already exists."
                            forKey:NSLocalizedRecoverySuggestionErrorKey];
            
            NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-201 userInfo:errorDetail];
            
            if (self.completeDefaultsAPI) {
                self.completeDefaultsAPI(NO, error);
            }
        }
        
        // Does not contain pre-defined constant key
        else {
            
            [userDefaults setObject:object forKey:key];
            
            // Success
            if ([[[userDefaults dictionaryRepresentation] allKeys] containsObject:key] &&
                [[userDefaults objectForKey:key] isEqual:object])
            {
                if (self.completeDefaultsAPI) {
                    self.completeDefaultsAPI(YES, nil);
                }
            }
            
            else {
                NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
                
                [errorDetail setObject:[NSString stringWithFormat:@"Failed to add Object-Key pair: {\"%@\":\"%@\"}; to Defaults.", object, key]
                                forKey:NSLocalizedDescriptionKey];
                
                [errorDetail setObject:@"Set breakpoints and log statements in the UserDefaults API to track the error."
                                forKey:NSLocalizedRecoverySuggestionErrorKey];
                
                NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-202 userInfo:errorDetail];
                
                if (self.completeDefaultsAPI) {
                    self.completeDefaultsAPI(NO, error);
                }
            }
        }
    }
    
    
    // Object attempting to be written is NOT a valid object type for User Defaults
    else {
        // Create dict for details
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        
        [errorDetail setObject:[NSString stringWithFormat:@"Attempt to write Object: %@; to Defaults that is not of valid object type.", object]
                        forKey:NSLocalizedDescriptionKey];
        
        [errorDetail setObject:@"NSUserDefaults only permits PropertyList types: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects"
                        forKey:NSLocalizedFailureReasonErrorKey];
        
        [errorDetail setObject:@"Ensure that the object is of type: NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. For NSArray and NSDictionary objects, their contents must be property list objects"
                        forKey:NSLocalizedRecoverySuggestionErrorKey];
        
        NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-200 userInfo:errorDetail];
        
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(NO, error);
        }
    }
}


// Specific Actions
- (void)saveFirstNameToDefaultsWithName:(NSString *)firstName
                        completionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    self.completeDefaultsAPI = completionBlock;
    
    [userDefaults setObject:firstName forKey:kFirstNameDefaultsKey];
    
    // Success
    if ([[userDefaults objectForKey:kFirstNameDefaultsKey] isEqual:firstName])
    {
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(YES, nil);
        }
    }
    
    else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        
        [errorDetail setObject:[NSString stringWithFormat:@"Failed to add First Name: %@; to Defaults.", firstName]
                        forKey:NSLocalizedDescriptionKey];
        
        [errorDetail setObject:@"Set breakpoints and log statements in the UserDefaults API to track the error."
                        forKey:NSLocalizedRecoverySuggestionErrorKey];
        
        NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-203 userInfo:errorDetail];
        
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(NO, error);
        }
    }

}

- (void)saveLastNameToDefaultsWithName:(NSString *)lastName
                       completionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    self.completeDefaultsAPI = completionBlock;
    
    [userDefaults setObject:lastName forKey:kLastNameDefaultsKey];
    
    // Success
    if ([[userDefaults objectForKey:kFirstNameDefaultsKey] isEqual:lastName])
    {
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(YES, nil);
        }
    }
    
    else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        
        [errorDetail setObject:[NSString stringWithFormat:@"Failed to add Last Name: %@; to Defaults.", lastName]
                        forKey:NSLocalizedDescriptionKey];
        
        [errorDetail setObject:@"Set breakpoints and log statements in the UserDefaults API to track the error."
                        forKey:NSLocalizedRecoverySuggestionErrorKey];
        
        NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-204 userInfo:errorDetail];
        
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(NO, error);
        }
    }
}

- (void)saveBaseToDefaultsWithBaseName:(NSString *)baseName
                       completionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    self.completeDefaultsAPI = completionBlock;
    
    [userDefaults setObject:baseName forKey:kBaseNameDefaultsKey];
    
    // Success
    if ([[userDefaults objectForKey:kFirstNameDefaultsKey] isEqual:baseName])
    {
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(YES, nil);
        }
    }
    
    else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        
        [errorDetail setObject:[NSString stringWithFormat:@"Failed to add Base Name: %@; to Defaults.", baseName]
                        forKey:NSLocalizedDescriptionKey];
        
        [errorDetail setObject:@"Set breakpoints and log statements in the UserDefaults API to track the error."
                        forKey:NSLocalizedRecoverySuggestionErrorKey];
        
        NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-205 userInfo:errorDetail];
        
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(NO, error);
        }
    }

}


#warning - Saving the profile image will need to coincide with saving to the server.
//         There must be a way to determine if the profile image has been downloaded yet.
//
//         Consider changing the NSData Object-Key pair to an NSDictionary in User Defaults
//         containing an "imageURL" parameter and an image NSData parameter.
//TODO: The UIImage will need to be converted to NSData in order to be saved to the User Defaults
- (void)saveProfileImageToDefaultsWithImage:(UIImage *)profileImage
                            completionBlock:(void (^)(BOOL, NSError *))completionBlock
{
    self.completeDefaultsAPI = completionBlock;
    
//    [userDefaults setObject:firstName forKey:kFirstNameDefaultsKey];
    
    
    NSData *imageDataRepresentation = UIImageJPEGRepresentation(profileImage, 1.0);
    
    [userDefaults setObject:imageDataRepresentation forKey:kProfileImageDefaultsKey];
    
    // Success
    if ([[userDefaults objectForKey:kProfileImageDefaultsKey] isEqual:imageDataRepresentation])
    {
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(YES, nil);
        }
    }
    
    else {
        NSMutableDictionary *errorDetail = [NSMutableDictionary dictionary];
        
        [errorDetail setObject:[NSString stringWithFormat:@"Failed to save profile image NSData representation to Defauls."]
                        forKey:NSLocalizedDescriptionKey];
        
        [errorDetail setObject:@"Set breakpoints and log statements in the UserDefaults API to track the error."
                        forKey:NSLocalizedRecoverySuggestionErrorKey];
        
        NSError *error = [NSError errorWithDomain:@"UserDefaults" code:-206 userInfo:errorDetail];
        
        if (self.completeDefaultsAPI) {
            self.completeDefaultsAPI(NO, error);
        }
    }
}

- (UIImage*)retrieveProfileImageFromDefaults {
    
    if ([[[userDefaults dictionaryRepresentation] allKeys] containsObject:kProfileImageDefaultsKey]) {
        if ([[userDefaults dictionaryRepresentation] objectForKey:kProfileImageDefaultsKey]) {
            return [UIImage imageWithData:[[userDefaults dictionaryRepresentation] objectForKey:kProfileImageDefaultsKey]];
        }
        
        else {
            return nil;
        }
    }
    
    else {
        return nil;
    }
}

#pragma mark - Helper Methods

- (BOOL)objectForDefaultsKeyIsValid:(id)object {
    
    if ([object isKindOfClass:[NSArray class]]) {
        if ([self objectsInArrayForDefaultsKeyAreValid: object]) {
            return YES;
        }
        
        else
            return NO;
    }
    
    else if ([object isKindOfClass:[NSDictionary class]]) {
        if ([self objectsInDictionaryForDefaultsKeyAreValid: object]) {
            return YES;
        }
        
        else
            return NO;
    }
    
    // All other data types
    else {
        return NO;
    }
}

- (BOOL)objectsInArrayForDefaultsKeyAreValid:(NSArray*)array {
    
    for (id object in array) {
        if (![object isKindOfClass:[NSData class]]    ||
            ![object isKindOfClass:[NSString class]]  ||
            ![object isKindOfClass:[NSNumber class]]  ||
            ![object isKindOfClass:[NSDate class]]      )
        {
            return NO;
        }
    }
    
    return YES;
}

- (BOOL)objectsInDictionaryForDefaultsKeyAreValid:(NSDictionary*)dictionary {
    
    NSArray *values = [dictionary allValues];
    
    for (id object in values) {
        if (![object isKindOfClass:[NSData class]]    ||
            ![object isKindOfClass:[NSString class]]  ||
            ![object isKindOfClass:[NSNumber class]]  ||
            ![object isKindOfClass:[NSDate class]]      )
        {
            return NO;
        }
    }
    
    return YES;
}


@end
