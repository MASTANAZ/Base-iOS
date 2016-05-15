//
//  ImageColorManipulator.h
//  ImageModifierTest
//
//  Created by Blake Nazario-Casey on 4/18/16.
//  Copyright © 2016 Example. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

+ (UIImage*)setBackgroundImageByColor:(UIColor *)backgroundColor withFrame:(CGRect )rect;

+ (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance;

+ (UIImage *)changeWhiteColorTransparent: (UIImage *)image;

+ (UIImage *)changeColorTo:(NSMutableArray*) array Transparent: (UIImage *)image;

//resizing Stuff...
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (UIImage *)negativeImageWithImage:(UIImage*)sourceImage;

+ (UIImage*) drawText:(NSString*) text
              inImage:(UIImage*)  image
              atPoint:(CGPoint)   point
            withColor:(UIColor*)  color;

@end
