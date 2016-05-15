//
//  M_PreviousCallModel+M_PreviousCall_TableRepresentation.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "M_PreviousCallModel+M_PreviousCall_TableRepresentation.h"

@implementation M_PreviousCallModel (M_PreviousCall_TableRepresentation)

- (NSDictionary*)m_pctr_previousCallTableRepresentation {
    return @{
             @"MapObjectType":self.mapObjectType,
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
