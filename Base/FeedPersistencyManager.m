//
//  FeedPersistencyManager.m
//  Base
//
//  Created by Blake Nazario-Casey on 1/27/16.
//  Copyright © 2016 Kudoko, LLC. All rights reserved.
//

#import "FeedPersistencyManager.h"
#import "HTTPClient.h"

@interface FeedPersistencyManager () {

    NSMutableArray *posts;
}

@end

@implementation FeedPersistencyManager

- (id)init
{
    self = [super init];
    if (self) {
        
        // Call the methods here to get the data; (e.g. self.getPosts;
        // posts = [self getPosts];
        
        // Dummy list of posts
        posts = [NSMutableArray arrayWithArray:
                 @[
                   [[TextPostModel alloc]initWithPostType:@"1" user:@{@"UserName":@"Dylan Rodgers", @"profileImageURL":@"http://www.heilbronnspringsfiredepartment.com/uploads/5/0/9/2/50929259/9008383_orig.jpg"} timestamp:@"Today, 03:45 PM" postBody:@"ATTENTION: Please do not run emergent response to any Correctional Facility for a medical call. In an effort to keep ourselves and citizens on roadways safe, running emergent response to the prison just to get there and stage for an ambulance is uncalled for."],
                   
                   [[MapPostModel alloc]initWithPostType:@"2" user:@{@"UserName":@"Dylan Rodgers", @"profileImageURL":@"http://thesocialmediamonthly.com/wp-content/uploads/2015/08/photo.png"} latitude:@"29.949689" longitude:@"-82.111474" address:@"13 N Lake St. Starke, FL 32091" timestamp:@"Today, 01:33 PM" callType:@"Structure Fire" information:@"Structure fire ongoing. Engine 40 responding times 4. Station 5 and Station 2 are also responding. May need the tanker." responders:@"Alex Hatch, Joel Haas, Ernie Williams, Dylan Rodgers" inProgress:@"1"],
                   
                   [[MapPostModel alloc]initWithPostType:@"2" user:@{@"UserName":@"Blake Nazario", @"profileImageURL":@"http://thesocialmediamonthly.com/wp-content/uploads/2015/08/photo.png"} latitude:@"30.042380" longitude:@"-82.149814" address:@"13 N Lake St. Starke, FL 32091" timestamp:@"Today, 01:33 PM" callType:@"Emergency Medical" information:@"Structure fire ongoing. Engine 40 responding times 4. Station 5 and Station 2 are also responding. May need the tanker." responders:@"Alex Hatch, Joel Haas, Ernie Williams, Dylan Rodgers" inProgress:@"0"],
                   
                   [[TextPostModel alloc]initWithPostType:@"1" user:@{@"UserName":@"Blake Nazario-Casey", @"profileImageURL":@"https://scontent-atl3-1.xx.fbcdn.net/hprofile-xpl1/v/t1.0-1/c75.100.614.614/s320x320/1936966_1193047807375405_42104655200456358_n.jpg?oh=154cdcba62991a1da9ad34b1983a5489&oe=57283A61"} timestamp:@"Today, 03:45 PM" postBody:@"******* Testing"]
                   
                 ]];
    }
    
    return self;
}

// This will be executed only when getting most current posts.
- (NSArray*)getPosts {
    
    // Interface with the HTTP client here.
    HTTPClient *client = [HTTPClient sharedInstance];
    [client performGETrequestWithURL:@"url with parameter for current posts"
                         completionBlock:^(BOOL success, NSData *responseData, NSError *error)
    {
        // decrypt the data
        
        // get array of posts
    }];
    
    
    // Testing
    return posts;
}

// This will be executed when retrieving posts outside of the first date range.
- (NSArray*)getPostsForNextDateRange {
    
    // Interface with the HTTP client here.
    HTTPClient *client = [HTTPClient sharedInstance];
    [client performGETrequestWithURL:@"url with parameter for posts in specified date range"
                         completionBlock:^(BOOL success, NSData *responseData, NSError *error)
     {
         // Do something with the returned data
     }];
    
    
    // testing
    return @[];
}


- (void)addTextPost:(TextPostModel*)textPost atIndex:(int)index {
    
    if (posts.count >= index) {
        NSLog(@"*** Feed persistence manager:Inserting TEXT post at index: %i", index);
        [posts insertObject:textPost atIndex:index];
    }
    
    else {
        NSLog(@"*** Feed persistence manager:Inserting TEXT post at end of posts array");
        [posts addObject:textPost];
    }
}

- (void)addMapPost:(MapPostModel*)mapPost atIndex:(int)index {
    
    if (posts.count >= index) {
        NSLog(@"*** Feed persistence manager:Inserting MAP post at index: %i", index);
        [posts insertObject:mapPost atIndex:index];
    }
    else {
        NSLog(@"*** Feed persistence manager:Inserting MAP post at end of posts array");
        [posts addObject:mapPost];
    }
}


// Store profile images
- (void)saveImage:(UIImage*)image filename:(NSString*)filename
{
#warning Make this method able to overwrite existing image for users instead of just saving to a new file.
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:filename atomically:YES];
}

- (UIImage*)getImage:(NSString*)filename
{
    filename = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", filename];
    NSData *data = [NSData dataWithContentsOfFile:filename];
    return [UIImage imageWithData:data];
}


@end
