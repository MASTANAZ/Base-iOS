//
//  ImageColorManipulator.m
//  ImageModifierTest
//
//  Created by Blake Nazario-Casey on 4/18/16.
//  Copyright © 2016 Example. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ImageManipulator.h"

@implementation UIImage (Color)

+ (UIImage* )setBackgroundImageByColor:(UIColor *)backgroundColor withFrame:(CGRect )rect{
    
    // tcv - temporary colored view
    UIView *tcv = [[UIView alloc] initWithFrame:rect];
    [tcv setBackgroundColor:backgroundColor];
    
    
    // set up a graphics context of button's size
    CGSize gcSize = tcv.frame.size;
    UIGraphicsBeginImageContext(gcSize);
    // add tcv's layer to context
    [tcv.layer renderInContext:UIGraphicsGetCurrentContext()];
    // create background image now
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
    //    [tcv release];
    
}


+ (UIImage*) replaceColor:(UIColor*)color inImage:(UIImage*)image withTolerance:(float)tolerance {
    
    CGImageRef imageRef = [image CGImage];
    
    NSUInteger width = CGImageGetWidth(imageRef) * .85;
    NSUInteger height = CGImageGetHeight(imageRef) * .85;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    NSUInteger bitmapByteCount = bytesPerRow * height;
    
    unsigned char *rawData = (unsigned char*) calloc(bitmapByteCount, sizeof(unsigned char));
    
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    
    CGColorRef cgColor = [color CGColor];
    const CGFloat *components = CGColorGetComponents(cgColor);
    float r = components[0];
    float g = components[1];
    float b = components[2];
    //float a = components[3]; // not needed
    
    r = r * 255.0;
    g = g * 255.0;
    b = b * 255.0;
    
    const float redRange[2] = {
        MAX(r + (tolerance / 2.0), 0.0),
        MIN(r + (tolerance / 2.0), 255.0)
    };
    
    const float greenRange[2] = {
        MAX(g + (tolerance / 2.0), 0.0),
        MIN(g + (tolerance / 2.0), 255.0)
    };
    
    const float blueRange[2] = {
        MAX(b + (tolerance / 2.0), 0.0),
        MIN(b + (tolerance / 2.0), 255.0)
    };

    int byteIndex = 0;
    
    while (byteIndex < bitmapByteCount) {
        unsigned char red   = rawData[byteIndex];
        unsigned char green = rawData[byteIndex + 1];
        unsigned char blue  = rawData[byteIndex + 2];
        
        if (((red >= redRange[0]) && (red <= redRange[1])) &&
            ((green >= greenRange[0]) && (green <= greenRange[1])) &&
            ((blue >= blueRange[0]) && (blue <= blueRange[1]))) {
            // make the pixel transparent
            //
            rawData[byteIndex] = 0;
            rawData[byteIndex + 1] = 0;
            rawData[byteIndex + 2] = 0;
            rawData[byteIndex + 3] = 0;
        }
        
        byteIndex += 4;
    }
    
    UIImage *result = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    
    CGContextRelease(context);
    free(rawData);
    
    return result;
}

+(UIImage *)changeWhiteColorTransparent: (UIImage *)image
{
    CGImageRef rawImageRef=image.CGImage;
    
    const float colorMasking[6] = {222, 255, 222, 255, 222, 255};
    
    UIGraphicsBeginImageContext(image.size);
    CGImageRef maskedImageRef=CGImageCreateWithMaskingColors(rawImageRef, (const double*)colorMasking);
    {
        //if in iphone
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    }
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(maskedImageRef);
    UIGraphicsEndImageContext();
    return result;
}




+ (UIImage *)changeColorTo:(NSMutableArray*) array Transparent: (UIImage *)image
{
    CGImageRef rawImageRef=image.CGImage;
    
    //    const float colorMasking[6] = {222, 255, 222, 255, 222, 255};
    
    const float colorMasking[6] = {[[array objectAtIndex:0] floatValue], [[array objectAtIndex:1] floatValue], [[array objectAtIndex:2] floatValue], [[array objectAtIndex:3] floatValue], [[array objectAtIndex:4] floatValue], [[array objectAtIndex:5] floatValue]};
    
    
    UIGraphicsBeginImageContext(image.size);
    CGImageRef maskedImageRef=CGImageCreateWithMaskingColors(rawImageRef, (const double*)colorMasking);
    {
        //if in iphone
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0.0, image.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
    }
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, image.size.width, image.size.height), maskedImageRef);
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    CGImageRelease(maskedImageRef);
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)negativeImageWithImage:(UIImage *)sourceImage
{
    UIImage *imageReference = [[UIImage alloc]init];
    // get width and height as integers, since we'll be using them as
    // array subscripts, etc, and this'll save a whole lot of casting
    CGSize size = sourceImage.size;
    int width = size.width;
    int height = size.height;
    
    // Create a suitable RGB+alpha bitmap context in BGRA colour space
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *memoryPool = (unsigned char *)calloc(width*height*4, 1);
    CGContextRef context = CGBitmapContextCreate(memoryPool, width, height, 8, width * 4, colourSpace, kCGBitmapByteOrder32Big | kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colourSpace);
    
    // draw the current image to the newly created context
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [imageReference CGImage]);
    
    // run through every pixel, a scan line at a time...
    for(int y = 0; y < height; y++)
    {
        // get a pointer to the start of this scan line
        unsigned char *linePointer = &memoryPool[y * width * 4];
        
        // step through the pixels one by one...
        for(int x = 0; x < width; x++)
        {
            // get RGB values. We're dealing with premultiplied alpha
            // here, so we need to divide by the alpha channel (if it
            // isn't zero, of course) to get uninflected RGB. We
            // multiply by 255 to keep precision while still using
            // integers
            int r, g, b;
            if(linePointer[3])
            {
                r = linePointer[0] * 255 / linePointer[3];
                g = linePointer[1] * 255 / linePointer[3];
                b = linePointer[2] * 255 / linePointer[3];
            }
            else
                r = g = b = 0;
            
            // perform the colour inversion
            r = 255 - r;
            g = 255 - g;
            b = 255 - b;
            
            // multiply by alpha again, divide by 255 to undo the
            // scaling before, store the new values and advance
            // the pointer we're reading pixel data from
            linePointer[0] = r * linePointer[3] / 255;
            linePointer[1] = g * linePointer[3] / 255;
            linePointer[2] = b * linePointer[3] / 255;
            linePointer += 4;
        }
    }
    
    // get a CG image from the context, wrap that into a
    // UIImage
    CGImageRef cgImage = CGBitmapContextCreateImage(context);
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    
    // clean up
    CGImageRelease(cgImage);
    CGContextRelease(context);
    free(memoryPool);
    
    // and return
    return returnImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    //UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return newImage;
}

+(UIImage*) drawText:(NSString*) text
             inImage:(UIImage*)  image
             atPoint:(CGPoint)   point
           withColor:(UIColor*)  color
{
    
    UIFont *font;
    
    if (image.size.width < image.size.height) {
        font = [UIFont boldSystemFontOfSize:image.size.width / 6];
    }
    else {
        font = [UIFont boldSystemFontOfSize:image.size.height / 6];
    }
    UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0,image.size.width,image.size.height)];
    CGRect rect = CGRectMake(point.x, point.y, image.size.width, image.size.height);
    [[UIColor redColor] set];
    [text drawInRect:CGRectIntegral(rect) withFont:font];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
