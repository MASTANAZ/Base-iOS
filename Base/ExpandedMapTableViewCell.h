//
//  ExpandedMapTableViewCell.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/25/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ExpandedMapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *mapsButton;
@property (weak, nonatomic) IBOutlet UIButton *respondButton;


- (IBAction)openInMapsTapped:(id)sender;
- (IBAction)respondButtonTapped:(id)sender;

@end
