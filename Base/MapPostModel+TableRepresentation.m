//
//  MapPostModel+TableRepresentation.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MapPostModel+TableRepresentation.h"

@implementation MapPostModel (TableRepresentation)

- (NSDictionary*)mtr_mapTableRepresentation {
    
    // Notice how this is accessing properties directly from "Album.h"
    return @{
             @"PostType":self.postType,
             @"User":self.user,
             @"Latitude":self.latitude,
             @"Longitude":self.longitude,
             @"Address":self.address,
             @"Timestamp":self.timestamp,
             @"CallType":self.callType,
             @"Information":self.information,
             @"Responders":self.responders,
             @"InProgress":self.isInProgress
             };

}
@end
