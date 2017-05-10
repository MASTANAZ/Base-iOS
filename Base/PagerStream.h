//
//  PagerStream.h
//  Base
//
//  Created by Blake Nazario on 5/8/17.
//  Copyright © 2017 Kudoko, LLC. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

@interface PagerStream : AVPlayer {
    
    NSURL *streamURL;
    
}


- (id)initWithURL:(NSURL *)URL;

@end
