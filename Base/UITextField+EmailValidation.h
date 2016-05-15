//
//  UITextField+EmailValidation.h
//  Base
//
//  Created by Blake Nazario on 4/21/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Email)

+ (BOOL)checkIfEmailIsValid:(NSString*)email;


@end
