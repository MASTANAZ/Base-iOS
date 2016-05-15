//
//  MapPersistencyManager.m
//  Base
//
//  Created by Blake Nazario-Casey on 2/8/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MapPersistencyManager.h"


@interface MapPersistencyManager () {
    
    NSMutableArray *mapObjects;
}

@end


@implementation MapPersistencyManager

- (id)init {
    self = [super init];
    
    if (self) {
        // dummy data of map objects
        // What will actually happen is this class will be the handler for retrieving and parsing the JSON.
        // The actual data call and parsing will occur in two separate classes.
        mapObjects = [NSMutableArray arrayWithArray:
                      @[
                        [[M_PreviousCallModel alloc]initWithMapObjectTypeType:@"1" user:@{@"UserName":@"Dylan Rodgers", @"profileImageURL":@"http://www.fastcompany.com/multisite_files/fastcompany/fc_files/profile/2219225-austin-carr-profile.jpg"} latitude:@"29.949689" longitude:@"-82.111474" address:@"13 N Lake St. Starke, FL 32091" timestamp:@"Today, 01:33 PM" callType:@"Structure Fire" information:@"Structure fire ongoing. Engine 40 responding times 4. Station 5 and Station 2 are also responding. May need the tanker." responders:@"Alex Hatch, Joel Haas, Ernie Williams, Dylan Rodgers" inProgress:@"0"],
                        
                        [[M_LandingZoneModel alloc]initWithMapObjectType:@"2" station:@"Station 4" backgroundColorHexValue:@"0022FF" boundingPoints:@[@{@"Latitude":@"29.960810", @"Longitude":@"-82.168177"},  @{@"Latitude":@"29.961555", @"Longitude":@"-82.168704"}, @{@"Latitude":@"29.961392", @"Longitude":@"-82.167992"}, @{@"Latitude":@"29.960898", @"Longitude":@"-82.168863"}]],
                        
                        [[M_HydrantModel alloc]initWithMapObjectType:@"3" hydrantID:@"10-1234" latitude:@"30.048331" longitude:@"-82.173692"],
                        
                        [[M_POIModel alloc]initWithMapObjectType:@"4" poiType:@"Testing POI" poiInfo:@"Testing POI Information" latitude:@"29.949880" longitude:@"-82.111670"]
    
                    ]];
    }
    
    return self;
}

- (NSArray*)getMapObjects {
    return mapObjects;
}


@end
