//
//  SecondViewController.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

// Map
#import "MapAPI.h"

#import "M_PreviousCallModel.h"
#import "M_PreviousCallModel+M_PreviousCall_TableRepresentation.h"

#import "M_LandingZoneModel.h"
#import "M_LandingZoneModel+M_LandingZoneModelTableRepresentation.h"

#import "M_HydrantModel.h"
#import "M_HydrantModel+M_HydrantModelTableRepresentation.h"

#import "M_POIModel.h"
#import "M_POIModel+M_POIModelTableRepresentation.h"


@interface SecondViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (strong, nonatomic) UIStoryboardSegue *ExpandedAnnotationSegue;

@end

