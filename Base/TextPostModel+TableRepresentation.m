//
//  TextPostModel+TableRepresentation.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "TextPostModel+TableRepresentation.h"

@implementation TextPostModel (TableRepresentation)

- (NSDictionary*)tptr_textPostTableRepresentation {
    
    // Notice how this is accessing properties directly from "Album.h"
    return @{
             @"PostType":self.postType,
             @"User":self.user,
             @"Timestamp":self.timestamp,
             @"PostBody":self.postBody,
             };
}

@end
