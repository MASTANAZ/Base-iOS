//
//  MapModel.h
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapModel : NSObject

@property (strong, nonatomic, readonly) NSArray *mapObjectsArray;

- (id)initWithMapObjectsArray:(NSArray*)mapObjectsArray;

@end
