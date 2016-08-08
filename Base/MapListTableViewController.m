//
//  MapListTableViewController.m
//  Base
//
//  Created by Blake Nazario on 5/2/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "MapListTableViewController.h"



@interface MapListTableViewController () {
    NSMutableArray *allMapObjects;
    NSDictionary *currentMapObjectData;
    NSMutableArray *totalMapObjects;
}

@end

@implementation MapListTableViewController


/*
 Total Map Objects data structure:
 
    Keys: Keys are the integer value for MapObjectTypes (e.g. 1, 2, 3, 4, etc.)
    Objects: Each key will contain one object: an NSArray. Each array for each key
             will contain Dictionaries of individual map objects.
 
    Each section title will correspond to the map object type (the key)
 
    If the key is not predefined (> 4), the objects will be displayed in
    the "other" section.
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"Passed in dict: %@", _passedInList);
    
    totalMapObjects = [[NSMutableArray alloc]init];
    
    for (int i = 0; i <_passedInList.count; i++) {
        [self parseMapObjectAtIndex:i];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parseMapObjectAtIndex:(int)index {
    NSLog(@"All Map Objects: %@", _passedInList);
    NSLog(@"Current map object: %@", currentMapObjectData);
    
    NSLog(@"index: %i", index);
    
    NSDictionary *currentObjectReferenceDict = [[NSDictionary alloc]init];
    
    if (index <= _passedInList.count) {
        NSLog(@"Index of map objects <= allMapObjects.count");
        
        // Key: 1
        if ([[_passedInList objectAtIndex:index] isKindOfClass:[M_PreviousCallModel class]]) {
            
            M_PreviousCallModel *previousCallObject = _passedInList[index];
            currentMapObjectData = [previousCallObject m_pctr_previousCallTableRepresentation];
            
            // Previous Call Key is not yet defined, add it to the dictionary.
            // Also insert Dictionary for current object into corresponding array for key
//            currentObjectReferenceDict
            currentObjectReferenceDict = [[NSDictionary alloc]initWithObjects:@[currentMapObjectData, @"1", @"Previous Call"]
                                                                      forKeys:@[@"MapObjectData", @"MapObjectType", @"TypeName"]];
            
            [totalMapObjects addObject:currentObjectReferenceDict];
        }
        
        // Key: 2
        else if ([[_passedInList objectAtIndex:index] isKindOfClass:[M_LandingZoneModel class]]) {
            
            M_LandingZoneModel *landingZoneObject = _passedInList[index];
            currentMapObjectData = [landingZoneObject m_lzmtr_landingZoneTableRepresentation];

            currentObjectReferenceDict = [[NSDictionary alloc]initWithObjects:@[currentMapObjectData, @"2", @"Landing Zone"]
                                                                      forKeys:@[@"MapObjectData", @"MapObjectType", @"TypeName"]];
            
            [totalMapObjects addObject:currentObjectReferenceDict];
        }
        
        // Key: 3
        else if ([[_passedInList objectAtIndex:index] isKindOfClass:[M_HydrantModel class]]) {
            
            M_HydrantModel *hydrantObject = _passedInList[index];
            currentMapObjectData = [hydrantObject m_hmtr_hydrantTableRepresentation];
            
            currentObjectReferenceDict = [[NSDictionary alloc]initWithObjects:@[currentMapObjectData, @"3", @"Hydrant"]
                                                                      forKeys:@[@"MapObjectData", @"MapObjectType", @"TypeName"]];
            
            [totalMapObjects addObject:currentObjectReferenceDict];
        }
        
        // Key: 4
        else if ([[_passedInList objectAtIndex:index]isKindOfClass:[M_POIModel class]]) {
            
            M_POIModel *poiObject = _passedInList[index];
            currentMapObjectData = [poiObject m_poimtr_poiTableRepresentation];
            
            currentObjectReferenceDict = [[NSDictionary alloc]initWithObjects:@[currentMapObjectData, @"4", @"Point of Interest"]
                                                                      forKeys:@[@"MapObjectData", @"MapObjectType", @"TypeName"]];
            
            [totalMapObjects addObject:currentObjectReferenceDict];
        }
        
        // Other / Misc (Values here should be raw dictionaries.)
        else {
            // Ensure compatible data types
            if ([allMapObjects[index] isKindOfClass:[NSDictionary class]]) {
                currentMapObjectData = [NSDictionary dictionaryWithDictionary:allMapObjects[index]];
                
                currentObjectReferenceDict = [[NSDictionary alloc]initWithObjects:@[currentMapObjectData, @"0", @"Other"]
                                                                          forKeys:@[@"MapObjectData", @"MapObjectType", @"TypeName"]];
                
                [totalMapObjects addObject:currentObjectReferenceDict];
            }
            
            else {
                // do nothing.
            }
        }
    }
    else {
        currentMapObjectData = nil;
    }
    
    NSLog(@"Total map objects: %@", totalMapObjects);

    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Adding +1 to account for index 0.
    NSString *sectionString = [NSString stringWithFormat:@"%li", section + 1];
//    NSInteger rowsForSection = 0;
//    for (NSDictionary *dict in totalMapObjects) {
//        NSArray *array = [dict allValues];
//        for (NSString *value in array) {
//            if ([value isEqualToString: sectionString]) {
//                rowsForSection += 1;
//            }
//        }
//    }
    
    NSLog(@"Section string: %@", sectionString);
    
    // Previous call
    if (section == 0) {
        NSInteger numberOfObjects = 0;
        for (NSDictionary *dict in totalMapObjects) {
            
            NSLog(@"Object tyupe: %@", [dict objectForKey:@"MapObjectType"]);
            
            if ([dict.allKeys containsObject:@"MapObjectType"]) {
                if ([[dict objectForKey:@"MapObjectType"] isEqualToString:sectionString]) {
                    numberOfObjects += 1;
                }
            }
        }
        
        NSLog(@"Number of Previous Calls: %li", numberOfObjects);
        
        return numberOfObjects;
    }
    
    
    else if (section == 1) {
        NSInteger numberOfObjects = 0;
        for (NSDictionary *dict in totalMapObjects) {
            if ([dict.allKeys containsObject:@"MapObjectType"]) {
                if ([[dict objectForKey:@"MapObjectType"] isEqualToString:sectionString]) {
                    numberOfObjects += 1;
                }
            }
        }
        NSLog(@"Number of Landing zones: %li", numberOfObjects);

        return numberOfObjects;
    }
    if (section == 2) {
        NSInteger numberOfObjects = 0;
        for (NSDictionary *dict in totalMapObjects) {
            if ([dict.allKeys containsObject:@"MapObjectType"]) {
                if ([[dict objectForKey:@"MapObjectType"] isEqualToString:sectionString]) {
                    numberOfObjects += 1;
                }
            }
        }
        NSLog(@"Number of Hydrants: %li", numberOfObjects);

        return numberOfObjects;
    }
    if (section == 3) {
        NSInteger numberOfObjects = 0;
        for (NSDictionary *dict in totalMapObjects) {
            if ([dict.allKeys containsObject:@"MapObjectType"]) {
                if ([[dict objectForKey:@"MapObjectType"] isEqualToString:sectionString]) {
                    numberOfObjects += 1;
                }
            }
        }
        NSLog(@"Number of POIs: %li", numberOfObjects);
        return numberOfObjects;
    }
    
    else {
        NSInteger numberOfObjects = 0;
        for (NSDictionary *dict in totalMapObjects) {
            if ([dict.allKeys containsObject:@"MapObjectType"]) {
                if ([[dict objectForKey:@"MapObjectType"] isEqualToString:@"0"]) {
                    numberOfObjects += 1;
                }
            }
        }
        NSLog(@"Number of Others: %li", numberOfObjects);

        return numberOfObjects;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListViewCell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"Testing";
    
    return cell;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Testing";
}


#pragma mark - Actions
- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
