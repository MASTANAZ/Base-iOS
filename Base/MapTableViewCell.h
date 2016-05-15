//
//  MapTableViewCell.h
//  Base
//
//  Created by Blake Nazario-Casey on 1/22/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *callTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *callTypeTitle;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *timestamp;

@end
