//
//  SelectedLegendItems.h
//  Base
//
//  Created by Blake Nazario on 7/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectedLegendItems : NSObject {
    NSMutableArray *selectedItemsIndex;
}

@property (nonatomic, retain) NSMutableArray *selectedItemsIndex;


- (SelectedLegendItems *)getInstance;


+ (void)updateSelectedItemsAtIndex:(NSIndexPath*)indexPath;

@end
