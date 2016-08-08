//
//  SelectedLegendItems.m
//  Base
//
//  Created by Blake Nazario on 7/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "SelectedLegendItems.h"

@implementation SelectedLegendItems

@synthesize selectedItemsIndex;

static SelectedLegendItems *instance = nil;

- (SelectedLegendItems *) getInstance {
    
    @synchronized(self)
    {
        if(instance==nil)
        {
            instance= [SelectedLegendItems new];
        }
    }
    
    return instance;
}

// Updater

+ (void)updateSelectedItemsAtIndex:(NSIndexPath *)indexPath {
    
}

@end