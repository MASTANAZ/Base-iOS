//
//  SecondViewController.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "SecondViewController.h"
#import "LMDropdownView.h"

// Cell
#import "LegendTableViewCell.h"

// Map
#import "BaseMapAnnotation.h"
#import "ExpandedMapTableViewController.h"

// List View
#import "MapListTableViewController.h"

@interface SecondViewController () <UITableViewDelegate, UITableViewDataSource, LMDropdownViewDelegate, MKMapViewDelegate> {
    NSArray *allMapObjects;
    NSDictionary *currentMapObjectData;
    int currentMapObjectIndex;
}

@property (strong, nonatomic) LMDropdownView *dropdownView;


@property (strong, nonatomic) IBOutlet UITableView *legendTableView;

@end

@implementation SecondViewController





#warning Things to Add to this Class!
//TODO: See following comments
/*
 1) Add images for annotations OR change color of pin based on annotation
 
 2) Allow filtering to work
 
 3) Allow adding of POIs by holding and dragging (similar to dropping pin in Maps app)
 ---3a) When user adds POI, they should have the option to share it with others. (e.g. POI becomes stored on database,
        not just their device.)
 
 
*/






NSArray *legendOptions;

// TEST DATA
NSArray *previousCalls;

// Map Object Types
//
//  0 = Other/Misc.
//  1 = Previous Call
//  2 = Landing Zone
//  3 = Hydrant
//  4 = POI Modele

NSMutableArray *totalMapObjects;

NSMutableArray *previousCallMapObjects;
NSMutableArray *landingZoneMapObjects;
NSMutableArray *hydrantMapObjects;
NSMutableArray *poiMapObjects;

NSString *selectedCalloutTitle;
int indexForTappedAnnotationCallout;

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    legendOptions = @[@"Tap a cell to toogle its appearance.", @"Previous Calls", @"Fire Hydrants", @"Fire Stations", @"Points of Interest"];
    
    [self.legendTableView setFrame:CGRectMake(0, 128,
                                              CGRectGetWidth(self.view.bounds),
                                              MIN(CGRectGetHeight(self.view.bounds)/2, legendOptions.count * 50))];
    
    
    _legendTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [_legendTableView setScrollEnabled:NO];
    
    allMapObjects = [[MapAPI sharedInstance] getMapObjects];
    totalMapObjects = [[NSMutableArray alloc]init];
    
    previousCallMapObjects = [[NSMutableArray alloc]init];
    landingZoneMapObjects = [[NSMutableArray alloc]init];
    hydrantMapObjects = [[NSMutableArray alloc]init];
    poiMapObjects = [[NSMutableArray alloc]init];
    
    currentMapObjectIndex = -1;
    
    for (int i = 0; i < allMapObjects.count; i++) {
        [self addMapAnnotationForObjectAtIndex: i];
    }
    
    
    [self setupMap];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MapView

- (void)setupMap {
    
    //TODO: Move most of this logic to another class that will take the user's current
    //      location and zoom to the nearest city/town with the user's position in view.
    //
    //  NOTE: This function will point to another class to handle the parsing and drawing of
    //        points on the map. As the other class' function returns coordinates, this
    //        function will add them in asyncronously.
    
    MKCoordinateRegion region;
    region.center.latitude = 29.948380;
    region.center.longitude = -82.110024;
    region.span.latitudeDelta = 0.2;
    region.span.longitudeDelta = 0.2;
    
    [self.mapView setRegion:region animated:YES];
    //    [self.mapView addAnnotation:annotation];
    [self.mapView setUserInteractionEnabled:YES];
}

- (void)parseMapObjectAtIndex:(int)index {
    NSLog(@"All Map Objects: %@", allMapObjects);
    NSLog(@"Current map object: %@", currentMapObjectData);
    
    NSLog(@"index: %i", index);
    
    
    if (index <= allMapObjects.count) {
        NSLog(@"Index of map objects <= allMapObjects.count");
        if ([[allMapObjects objectAtIndex:index] isKindOfClass:[M_PreviousCallModel class]]) {
            
            M_PreviousCallModel *previousCallObject = allMapObjects[index];
            currentMapObjectData = [previousCallObject m_pctr_previousCallTableRepresentation];
            [totalMapObjects addObject:currentMapObjectData];
            
        }
        
        else if ([[allMapObjects objectAtIndex:index] isKindOfClass:[M_LandingZoneModel class]]) {
            
            M_LandingZoneModel *landingZoneObject = allMapObjects[index];
            currentMapObjectData = [landingZoneObject m_lzmtr_landingZoneTableRepresentation];
            [totalMapObjects addObject:currentMapObjectData];
        }
        
        else if ([[allMapObjects objectAtIndex:index] isKindOfClass:[M_HydrantModel class]]) {
            
            M_HydrantModel *hydrantObject = allMapObjects[index];
            currentMapObjectData = [hydrantObject m_hmtr_hydrantTableRepresentation];
            [totalMapObjects addObject:currentMapObjectData];
        }
        
        else if ([[allMapObjects objectAtIndex:index]isKindOfClass:[M_POIModel class]]) {
            
            
            M_POIModel *poiObject = allMapObjects[index];
            currentMapObjectData = [poiObject m_poimtr_poiTableRepresentation];
            [totalMapObjects addObject:currentMapObjectData];
        }
    }
    
    else {
        currentMapObjectData = nil;
    }
}

#pragma mark Adding Annotations
- (void)addMapAnnotationForObjectAtIndex:(int)index {
    currentMapObjectIndex = currentMapObjectIndex + 1;
    
    if (currentMapObjectIndex < allMapObjects.count) {
        [self parseMapObjectAtIndex: currentMapObjectIndex];
    }
    
    // Previous Call
    if ([[[totalMapObjects objectAtIndex:index] objectForKey:@"MapObjectType"] isEqualToString:@"1"]) {
        BaseMapAnnotation     *annotation = [[BaseMapAnnotation alloc] init];
        CLLocationCoordinate2D myCoordinate;
        
        myCoordinate.latitude = [[[totalMapObjects objectAtIndex:index] objectForKey:@"Latitude"] doubleValue];
        myCoordinate.longitude = [[[totalMapObjects objectAtIndex:index] objectForKey:@"Longitude"] doubleValue];
        
        annotation.title = [[totalMapObjects objectAtIndex:index] objectForKey:@"CallType"];
        annotation.subtitle = [NSString stringWithFormat:@"Received: %@", [[totalMapObjects objectAtIndex:index] objectForKey:@"Timestamp"]];
        
        annotation.annotationsDataIndex = [NSNumber numberWithInt:index];
        
        annotation.coordinate = myCoordinate;
        
        
        
        [self.mapView addAnnotation:annotation];
    }
    
    // Landing Zone
    else if ([[[totalMapObjects objectAtIndex:index] objectForKey:@"MapObjectType"] isEqualToString:@"2"]) {
        MKPolygon *landingZone = [self getPointsForArrayOfPoints:[[totalMapObjects objectAtIndex:index]
                                                                  objectForKey:@"BoundingPoints"]
                                  ];
        
        [landingZone setTitle:[[totalMapObjects objectAtIndex:index] objectForKey:@"Station"]];
        NSLog(@"Landing Zone Polygon: %@", landingZone);
        
        
        landingZone.title = @"Air Lift Landing Zone";
        landingZone.subtitle = [NSString stringWithFormat:@"Parent Station: %@", [[totalMapObjects objectAtIndex:index] objectForKey:@"Station"]];
        
        [self.mapView addOverlay:landingZone];
    }
    
    // Hydrant
    else if ([[[totalMapObjects objectAtIndex:index] objectForKey:@"MapObjectType"] isEqualToString:@"3"]) {
        BaseMapAnnotation *hydrantAnnotation = [[BaseMapAnnotation alloc]init];
        CLLocationCoordinate2D hydrantCoordinate;
        
        hydrantCoordinate.latitude = [[[totalMapObjects objectAtIndex:index] objectForKey:@"Latitude"] doubleValue];
        hydrantCoordinate.longitude =[[[totalMapObjects objectAtIndex:index] objectForKey:@"Longitude"]doubleValue];
        
        hydrantAnnotation.title = @"Fire Hydrant";
        hydrantAnnotation.subtitle = [[totalMapObjects objectAtIndex:index] objectForKey:@"HydrantID"];
        
        hydrantAnnotation.coordinate = hydrantCoordinate;
        
        hydrantAnnotation.annotationsDataIndex = [NSNumber numberWithInt:index];

        [self.mapView addAnnotation:hydrantAnnotation];
    }
    
    // POI
    else if ([[[totalMapObjects objectAtIndex:index] objectForKey:@"MapObjectType"] isEqualToString:@"4"]) {
#pragma warning POI not adding to map
        NSLog(@"ADDING POI TO MAP");
        
        BaseMapAnnotation     *annotation = [[BaseMapAnnotation alloc] init];
        CLLocationCoordinate2D myCoordinate;
        
        myCoordinate.latitude = [[[totalMapObjects objectAtIndex:index] objectForKey:@"Latitude"] doubleValue];
        myCoordinate.longitude = [[[totalMapObjects objectAtIndex:index] objectForKey:@"Longitude"] doubleValue];
        
        annotation.title = [[totalMapObjects objectAtIndex:index] objectForKey:@"POI Type"];
        annotation.subtitle = [[totalMapObjects objectAtIndex:index] objectForKey:@"POI Info"];
        
        annotation.coordinate = myCoordinate;
        
        annotation.annotationsDataIndex = [NSNumber numberWithInt:index];
        
        [self.mapView addAnnotation:annotation];

    }
    
    // Unkown data type
    else {
        // Create alert controller to let user know some data could not be loaded
    }
    
    
}


- (MKPolygon*)getPointsForArrayOfPoints:(NSArray*)array {
    
    NSLog(@"*** Getting points from array of points: %@", array);
    
    NSMutableSet *set = [[NSMutableSet alloc] init];
    NSMutableArray *arr = [NSMutableArray arrayWithArray: array];
    
    [set addObjectsFromArray:arr];
    
    long count = set.count;
    
    CLLocationCoordinate2D *coords = calloc(count, sizeof(CLLocationCoordinate2D));
    
    int i = 0;
    
    for (NSMutableDictionary *dicT in set)
    {
        NSLog(@"Dictionary in Set: %@", dicT);
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([[dicT objectForKey:@"Latitude"] doubleValue], [[dicT objectForKey:@"Longitude"] doubleValue]);
        coords[i] = coord;
        i++;
    }
    
    MKPolygon *polygon = [MKPolygon polygonWithCoordinates:coords count:count];
    NSLog(@"Polygon Before renderer: %@", polygon);
    return polygon;
}

- (MKOverlayRenderer *) mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    
#warning This is where you will determine what color the renders should be for the landing zones
    
    if ([overlay isKindOfClass:[MKPolygon class]]) {
        
        NSLog(@"Polygon in renderer: %@", overlay);
        MKPolygonRenderer *polygonView = [[MKPolygonRenderer alloc]initWithPolygon:overlay];
        polygonView.strokeColor = [UIColor blueColor];
        polygonView.fillColor = [UIColor colorWithRed:0.1333 green:0.3372 blue:1.0 alpha:0.5];
        polygonView.lineWidth = 3.0f;
        
        return polygonView;
    }
    
    else {
        return nil;
    }
}

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
#warning Here, set the view (pin type) for each type of annotation (e.g. hydrant, previous call, etc.)
    
    static NSString *const kAnnotationReuseIdentifier = @"BaseMapAnnotationView";
    
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:kAnnotationReuseIdentifier];
    if (annotationView == nil) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kAnnotationReuseIdentifier];
        annotationView.enabled = YES;
        annotationView.canShowCallout = YES;
        
        BaseMapAnnotation *currentAnnotation = (BaseMapAnnotation*)annotationView.annotation;
        
#pragma warning Create assets for all call types and fill in here. NOTE: Any unknown titles shall be handled with a default image.
        UIImageView *calloutAccessoryImageView;
        if ([currentAnnotation.title isEqualToString:@"Structure Fire"]) {
            calloutAccessoryImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Base-MapAnnotation-Fire-2 copy.png"]];
            annotationView.leftCalloutAccessoryView = calloutAccessoryImageView;

        }
        
        else if ([currentAnnotation.title isEqualToString:@"Emergency Medical"]) {
            calloutAccessoryImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Base-MapAnnotation-EmergencyMedical-2 copy.png"]];
            annotationView.leftCalloutAccessoryView = calloutAccessoryImageView;
        }
        
        else {
            // none
        }
        
        calloutAccessoryImageView.frame = CGRectMake(0,0,35,35);
        
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        annotationView.tintColor = [UIColor colorWithRed:255/255.0 green:68/255.0 blue:74/255.0 alpha:1];
    }
    
    return annotationView;
}

#pragma mark Open Expanded Callout
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    NSLog(@"Tapped callout for: %@", [view.annotation title]);
    
    if ([view.annotation isKindOfClass:[BaseMapAnnotation class]]) {
        BaseMapAnnotation *tappedAnnotation = (BaseMapAnnotation*)view.annotation;
        indexForTappedAnnotationCallout = [tappedAnnotation.annotationsDataIndex intValue];
        
        NSLog(@"****** TAPPED ANNOTATION AT INDEX: %i", indexForTappedAnnotationCallout);
        
        selectedCalloutTitle = [NSString stringWithString:tappedAnnotation.title];
        
        [self performSegueWithIdentifier:@"ExpandedAnnotationSegue" sender:self];
    }
    
}


#pragma mark - DROPDOWN VIEW

- (void)showDropDownView
{
    // Init dropdown view
    if (!self.dropdownView) {
        self.dropdownView = [LMDropdownView dropdownView];
        self.dropdownView.delegate = self;
        
        // Customize Dropdown style
        self.dropdownView.closedScale = 1.0; //0.85;
        self.dropdownView.blurRadius = 5;
        self.dropdownView.blackMaskAlpha = 0.5;
        self.dropdownView.animationDuration = 0.5;
        self.dropdownView.animationBounceHeight = 0; //20;
        self.dropdownView.contentBackgroundColor = [UIColor clearColor]; //[UIColor colorWithRed:0.9843 green:0.1647 blue:0.2275 alpha:1.0];
    }
    
    // Show/hide dropdown view
    if ([self.dropdownView isOpen]) {
        [self.dropdownView hide];
    }
    else {
        [self.dropdownView showFromNavigationController:self.navigationController withContentView:self.legendTableView];
    }
}

- (void)dropdownViewWillShow:(LMDropdownView *)dropdownView
{
    [UIView animateWithDuration: self.dropdownView.animationDuration animations:^{
        [self.navigationItem.rightBarButtonItem setTitle:@"Close"];
        [UIView commitAnimations];
    }];
    NSLog(@"Dropdown view will show");
}

- (void)dropdownViewDidShow:(LMDropdownView *)dropdownView
{
    
    
    NSLog(@"Dropdown view did show");
}

- (void)dropdownViewWillHide:(LMDropdownView *)dropdownView
{
    [UIView animateWithDuration: self.dropdownView.animationDuration animations:^{
        [self.navigationItem.rightBarButtonItem setTitle:@"Legend"];
        [UIView commitAnimations];
    }];
    NSLog(@"Dropdown view will hide");
}

- (void)dropdownViewDidHide:(LMDropdownView *)dropdownView
{
    NSLog(@"Dropdown view did hide");
    // Adjust which annotations are shown here!
    
    
    //    switch (self.currentMapTypeIndex) {
    //        case 0:
    //            self.mapView.mapType = MKMapTypeStandard;
    //            break;
    //        case 1:
    //            self.mapView.mapType = MKMapTypeSatellite;
    //            break;
    //        case 2:
    //            self.mapView.mapType = MKMapTypeHybrid;
    //            break;
    //        default:
    //            break;
    //    }
}


#pragma mark - TABLE VIEW

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [legendOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LegendTableViewCell *cell = (LegendTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"LegendCell"];
    if (!cell) {
        NSLog(@"*** Legend Table View *** Error: Unable to load LegendTableViewCell; Creating substitute.");
        cell = (LegendTableViewCell*)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"menuCell"];
    }
    
    // Make sure the user can't select the first cell
    if (indexPath.row == 0) {
        [cell setUserInteractionEnabled:NO];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    
    cell.textLabel.text =      [legendOptions objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    cell.backgroundColor =              [UIColor clearColor];
    cell.contentView.backgroundColor =  [UIColor clearColor];
    cell.accessoryView.tintColor =      [UIColor colorWithRed:0.0 green:0.8393 blue:0.0 alpha:1.0];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.checkmarkImageView.backgroundColor =    [UIColor clearColor];
    cell.mapItemTypeImageView.backgroundColor =  [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass: [LegendTableViewCell class]]) {
        LegendTableViewCell *legendCell = (LegendTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        [legendCell.checkmarkImageView setHidden:NO];
    }
    
    else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    //    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    //    self.currentMapTypeIndex = indexPath.row;
    //    [self.dropdownView hide];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass: [LegendTableViewCell class]]) {
        LegendTableViewCell *legendCell = (LegendTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        
        [legendCell.checkmarkImageView setHidden:YES];
    }
    
    else {
        [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 35.0f;
    }
    
    else {
        return 50.0f;
    }
}


#pragma mark - Navigation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ExpandedAnnotationSegue"]) {
        
        ExpandedMapTableViewController *expandedAnnotationVC = (ExpandedMapTableViewController *)segue.destinationViewController;
        expandedAnnotationVC.passedInInfoDict = [NSDictionary dictionaryWithDictionary:[totalMapObjects objectAtIndex:indexForTappedAnnotationCallout]];

        // Previous Call
        if ([[[totalMapObjects objectAtIndex:indexForTappedAnnotationCallout] objectForKey:@"MapObjectType"] isEqualToString:@"1"]) {
            NSLog(@"*** Preparing for Segue to Expand Annotation with Dict: %@", [totalMapObjects objectAtIndex:indexForTappedAnnotationCallout]);
            expandedAnnotationVC.mapObjectType = @"1";
            expandedAnnotationVC.sectionTitles = @[@"Location", @"Information", @"Responders"];
        }
        
        // Landing Zone
        else if ([[[totalMapObjects objectAtIndex:indexForTappedAnnotationCallout] objectForKey:@"MapObjectType"] isEqualToString:@"2"]) {
            expandedAnnotationVC.mapObjectType = @"2";
            

        }
        
        // Hydrant
        else if ([[[totalMapObjects objectAtIndex:indexForTappedAnnotationCallout] objectForKey:@"MapObjectType"] isEqualToString:@"3"]) {
            expandedAnnotationVC.mapObjectType = @"3";
            expandedAnnotationVC.sectionTitles = @[@"Location", @"HydrantID"];

        }
        
        // POI
        else if ([[[totalMapObjects objectAtIndex:indexForTappedAnnotationCallout] objectForKey:@"MapObjectType"] isEqualToString:@"4"]) {
            expandedAnnotationVC.mapObjectType = @"4";
            expandedAnnotationVC.sectionTitles = @[@"Location", @"POI Type", @"POI Info"];
        }
        
        // Generic data type
        else {
            expandedAnnotationVC.mapObjectType = @"Gen";
        }
        
        expandedAnnotationVC.passedInTitle = selectedCalloutTitle;
    }
    
    if ([segue.identifier isEqualToString:@"ListViewSegue"]) {
        MapListTableViewController *listView = (MapListTableViewController*)segue.destinationViewController.childViewControllers[0];
        
        listView.passedInList = [NSArray arrayWithArray:allMapObjects];
    }
}

#pragma mark - EVENTS

- (IBAction)titleButtonTapped:(id)sender
{
    [self.legendTableView reloadData];
    
    [self showDropDownView];
}

- (IBAction)listButtonTapped:(id)sender {
    [self performSegueWithIdentifier:@"ListViewSegue" sender:self];
}

@end
