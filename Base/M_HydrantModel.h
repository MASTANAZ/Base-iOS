//
//  M_HydrantModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface M_HydrantModel : NSObject

@property (strong, nonatomic, readonly) NSString *mapObjectType, *hydrantID, *latitude, *longitude;

- (id)initWithMapObjectType:(NSString*)mapObjectType
                  hydrantID:(NSString*)hydrantID
                   latitude:(NSString*)latitude
                  longitude:(NSString*)longitude;

@end
