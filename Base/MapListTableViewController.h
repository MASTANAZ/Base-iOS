//
//  MapListTableViewController.h
//  Base
//
//  Created by Blake Nazario on 5/2/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

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

@interface MapListTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *passedInList;

@end
