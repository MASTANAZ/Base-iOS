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

// API Persistency Methods
- (void)getUserDefaultsKeysWithCompletionBlock:(void (^)(BOOL success, NSArray *keys, NSError *error))completionBlock;


// API Methods
- (void)syncDefaultsWithCompletionBlock:(void (^)(BOOL success, NSError *error))completionBlock; // Deprecated, not necessary

- (void)setDefaultsObject:(id)object forKey:(NSString*)key
      completionBlock:(void (^)(BOOL success, NSError *error))completionBlock; // Potentially Volatile


// Specific Actions
- (void)saveFirstNameToDefaultsWithName:(NSString*)firstName
                    completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

- (void)saveLastNameToDefaultsWithName:(NSString*)lastName
                   completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

- (void)saveBaseToDefaultsWithBaseName:(NSString*)baseName
                   completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

- (void)saveProfileImageToDefaultsWithImage:(UIImage*)profileImage
                        completionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

- (UIImage*)retrieveProfileImageFromDefaults;



@end
