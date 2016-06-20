//
//  FeedAPI.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "FeedAPI.h"
#import "HTTPClient.h"
#import "FeedPersistencyManager.h"
#import "TestPostTableViewCell.h"

@interface FeedAPI () {
    FeedPersistencyManager *persistencyManager;
    HTTPClient *httpClient;
    
    // isOnline determines if the server should be updated with any changes made to the albums list, such as added or deleted albums.
    BOOL isOnline;
}

@end

@implementation FeedAPI

#pragma mark - Class Life Cycle

+ (FeedAPI*)sharedInstance {
    
    // 1) Declare a static variable to hold the instance of your class, ensuring it’s available globally inside your class.
    static FeedAPI *_sharedInstance = nil;
    
    // 2) Declare the static variable dispatch_once_t which ensures that the initialization code executes only once.
    static dispatch_once_t oncePredicate;
    
    // Use Grand Central Dispatch (GCD) to execute a block which initializes an instance of LibraryAPI.
    // This is the essence of the Singleton design pattern: the initializer is never called again once the class has been instantiated.
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[FeedAPI alloc]init];
    });
    
    return _sharedInstance;
}

- (id)init {
    
    self = [super init];
    if (self) {
        persistencyManager = [[FeedPersistencyManager alloc] init];
        httpClient = [[HTTPClient alloc] init];
        
        // The HTTP client doesn’t actually work with a real server and is only here to demonstrate the usage of the
        // facade pattern, so isOnline will always be NO.
        isOnline = NO;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(downloadImage:)
                                                     name:@"BLDownloadImageNotification"
                                                   object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray*)getPosts {
    
    return [persistencyManager getPosts];
}

- (NSArray*)getPostsForNextDateRange {
    return [persistencyManager getPostsForNextDateRange];
}

- (void)downloadImage:(NSNotification*)notification
{
    // 1) downloadImage is executed via notifications and so the method receives the notification object as a parameter.
    //    The UIImageView and image URL are retrieved from the notification.
    UIImageView *imageView = notification.userInfo[@"imageView"];
    NSString *profileImageURL = notification.userInfo[@"profileImageURL"];
    
    NSLog(@"CELL: %@", notification.userInfo[@"cell"]);
        
    // 2) Retrieve the image from the PersistencyManager if it’s been downloaded previously
    imageView.image = [persistencyManager getImage:[profileImageURL lastPathComponent]];
    NSLog(@"Image is saved");
    if (imageView.image == nil)
    {
        
        NSLog(@"Image is not saved");
        
        // 3) If the image hasn’t already been downloaded, then retrieve it using HTTPClient.
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [httpClient downloadImage:profileImageURL];
            
            // 4) When the download is complete, display the image in the image view and use the PersistencyManager to save it locally.
            dispatch_sync(dispatch_get_main_queue(), ^{
                imageView.image = image;
                NSLog(@"Download complete");
                
                // If the image can't be downloaded
                if (imageView.image == nil) {
                    NSLog(@"Image is stil Nil");
#warning Replace this image here with a "Could not be downloaded" image.
                    imageView.image = [UIImage imageNamed:@"fire.png"];
                }
                
                // Image successfully downloaded
                else {
                    TestPostTableViewCell *cell = notification.userInfo[@"cell"];
                    [cell.profileImage setImage: [persistencyManager getImage:[profileImageURL lastPathComponent]]];
                }
                
                [persistencyManager saveImage:image filename:[profileImageURL lastPathComponent]];
            });
        });
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (imageView.image == nil) {
                NSLog(@"Image could not be retrieved.");
            }
            
            else {
                TestPostTableViewCell *cell = notification.userInfo[@"cell"];
                [cell.profileImage setImage: [persistencyManager getImage:[profileImageURL lastPathComponent]]];
                [cell.profileImage.layer setCornerRadius:.5 * cell.profileImage.frame.size.width];
                cell.profileImage.clipsToBounds = YES;
                NSLog(@"Retrieved saved image");
            }
            
        });
    });
}


@end
