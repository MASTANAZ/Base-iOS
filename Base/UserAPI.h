//
//  UserAPI.h
//  Base
//
//  Created by Blake Nazario on 8/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

/* Create "user" variable that can be used to perform User API actions.
 
   e.g. [user logout];
*/
#define user [UserAPI sharedInstance]

typedef void (^CompleteLogout)(BOOL success, NSError *error);

@interface UserAPI : NSObject

@property (copy, nonatomic) CompleteLogout completeLogout;

+ (UserAPI*)sharedInstance;

- (void)logoutUserWithCompletionBlock:(void (^)(BOOL success, NSError *error))completionBlock;

@end
