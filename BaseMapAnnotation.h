//
//  BaseMapAnnotation.h
//  Base
//
//  Created by Blake Nazario on 2/10/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BaseMapAnnotation : NSObject <MKAnnotation> {
@private
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
    NSString *_subtitle;
}

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

// Non-generically Typed Properties
@property (nonatomic, copy) NSNumber *annotationsDataIndex;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end
