//
//  NSUserDefaultsAPI.h
//  Base
//
//  Created by Blake Nazario on 5/4/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//Constants
#import "BaseUserDefaultsConstants.h"

typedef void (^CompleteDefaultsAPI)(BOOL success, NSError *error);
typedef void (^CompleteKeysForDefaults)(BOOL success, NSArray *keys, NSError *error);

@interface NSUserDefaultsAPI : NSObject

@property (copy, nonatomic) CompleteDefaultsAPI completeDefaultsAPI;
@property (copy, nonatomic) CompleteKeysForDefaults completeKeysForDefaults;

+ (NSUserDefaultsAPI*)sharedInstance;



//// API Persistency Methods

/**
 Get all keys that are currently stored in NSUserDefaults. Keys will be returned as an NSArray in a completion block.
 **/
- (void)getUserDefaultsKeysWithCompletionBlock:(void (^)(BOOL success, NSArray *keys, NSError *error))completionBlock;



//// API Methods

/**
 Manually synchronize defaults.
 **/
- (void)syncDefaultsWithCompletionBlock:(void (^)(BOOL success, NSError *error))completionBlock; // Deprecated, not necessary

/**
 Define an object for a key in NSUserDefaults. If the key does not yet exist, it creates a new one; if the key does exist, it will overwrite.
 **/
- (void)setDefaultsObject:(id)object forKey:(NSString*)key
      completionBlock:(void (^)(BOOL success, NSError *error))completionBlock; // Potentially Volatile



//// Specific Actions

/**
 Save the user's first name to NSUserDefaults; saves to specific key.
 
 @param firstName The user's first name NSString.
 
 @warning `firstName` must not be `nil`.
 **/
- (void)saveFirstNameToDefaultsWithName:(NSString*)firstName
                    completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

/**
 Save the user's last name to NSUserDefaults; saves to specific key.
 
 @param lastName The user's last name NSString.
 
 @warning `lastName` must not be `nil`.
 **/
- (void)saveLastNameToDefaultsWithName:(NSString*)lastName
                   completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

/**
 Save the user's current Base name to NSUserDefaults; saves to specific key.
 
 @param baseName The user's current base name NSString.
 
 @warning `baseName` must not be `nil`.
 **/
- (void)saveBaseToDefaultsWithBaseName:(NSString*)baseName
                   completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

/**
 Save the user's current profile image to NSUserDefaults; saves to specific key.
 
 @param `profileImage` The users profile image as a UIImage.
 
 @warning `profileImage` must not be `nil`.
 **/
- (void)saveProfileImageToDefaultsWithImage:(UIImage*)profileImage
                        completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

/**
 Retrieve the user's profile image in a UIImage instance.
 **/
- (UIImage*)retrieveProfileImageFromDefaults;



@end
