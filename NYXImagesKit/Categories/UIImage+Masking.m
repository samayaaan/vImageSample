//
//  UIImage+Masking.m
//  NYXImagesKit
//
//  Created by @Nyx0uf on 02/06/11.
//  Copyright 2012 Benjamin Godard. All rights reserved.
//  www.cococabyss.com
//


#import "UIImage+Masking.h"


@implementation UIImage (NYX_Masking)

-(UIImage*)maskWithImage:(UIImage*)maskImage
{
	/// Create a bitmap context with valid alpha
	const size_t originalWidth = self.size.width;
	const size_t originalHeight = self.size.height;
	CGContextRef bmContext = NYXCreateARGBBitmapContext(originalWidth, originalHeight, 0);
	if (!bmContext)
		return nil;

	/// Image quality
	CGContextSetShouldAntialias(bmContext, true);
	CGContextSetAllowsAntialiasing(bmContext, true);
	CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);

	/// Image mask
	CGImageRef cgMaskImage = maskImage.CGImage; 
	CGImageRef mask = CGImageMaskCreate(maskImage.size.width, maskImage.size.height, CGImageGetBitsPerComponent(cgMaskImage), CGImageGetBitsPerPixel(cgMaskImage), CGImageGetBytesPerRow(cgMaskImage), CGImageGetDataProvider(cgMaskImage), NULL, false);

	/// Draw the original image in the bitmap context
	const CGRect r = (CGRect){.origin.x = 0.0f, .origin.y = 0.0f, .size.width = originalWidth, .size.height = originalHeight};
	CGContextClipToMask(bmContext, r, cgMaskImage);
	CGContextDrawImage(bmContext, r, self.CGImage);

	/// Get the CGImage object
	CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(bmContext);
	/// Apply the mask
	CGImageRef maskedImageRef = CGImageCreateWithMask(imageRefWithAlpha, mask);

	UIImage* result = [UIImage imageWithCGImage:maskedImageRef];

	/// Cleanup
	CGImageRelease(maskedImageRef);
	CGImageRelease(imageRefWithAlpha);
	CGContextRelease(bmContext);
	CGImageRelease(mask);

    return result;
}

// mIto

-(UIImage*)maskWithImage2:(UIImage*)maskImage
{
//    //元画像
//    UIImage *iconImage = self;
//    
//    //マスク画像をCGImageに変換する
//    CGImageRef maskRef = maskImage.CGImage;
//    //マスクを作成する
//    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
//                                        CGImageGetHeight(maskRef),
//                                        CGImageGetBitsPerComponent(maskRef),
//                                        CGImageGetBitsPerPixel(maskRef),
//                                        CGImageGetBytesPerRow(maskRef),
//                                        CGImageGetDataProvider(maskRef), NULL, false);
//    
//    //マスクの形に切り抜く
//    CGImageRef masked = CGImageCreateWithMask([iconImage CGImage], mask);
//    //CGImageをUIImageに変換する
//    UIImage *maskedImage = [UIImage imageWithCGImage:masked];
//    
//    CGImageRelease(mask);
//    CGImageRelease(masked);
//    
//    return maskedImage;
    
    /// Create a bitmap context with valid alpha
	const size_t originalWidth = self.size.width;
	const size_t originalHeight = self.size.height;
	CGContextRef bmContext = NYXCreateARGBBitmapContext(originalWidth, originalHeight, 0);
	if (!bmContext)
		return nil;
    
	/// Image quality
	CGContextSetShouldAntialias(bmContext, true);
	CGContextSetAllowsAntialiasing(bmContext, true);
	CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);
    
	/// Image mask
	CGImageRef cgMaskImage = maskImage.CGImage;
	CGImageRef mask = CGImageMaskCreate(maskImage.size.width, maskImage.size.height, CGImageGetBitsPerComponent(cgMaskImage), CGImageGetBitsPerPixel(cgMaskImage), CGImageGetBytesPerRow(cgMaskImage), CGImageGetDataProvider(cgMaskImage), NULL, false);
    
    
	/// Draw the original image in the bitmap context
	const CGRect r = (CGRect){.origin.x = 0.0f , .origin.y = 0.0f, .size.width = originalWidth, .size.height = originalHeight};
	CGContextClipToMask(bmContext, r, cgMaskImage);
	CGContextDrawImage(bmContext, r, self.CGImage);
    
	/// Get the CGImage object
	CGImageRef imageRefWithAlpha = CGBitmapContextCreateImage(bmContext);
	/// Apply the mask
	CGImageRef maskedImageRef = CGImageCreateWithMask(imageRefWithAlpha, mask);
    
	UIImage* result = [UIImage imageWithCGImage:maskedImageRef];
    
	/// Cleanup
	CGImageRelease(maskedImageRef);
	CGImageRelease(imageRefWithAlpha);
	CGContextRelease(bmContext);
	CGImageRelease(mask);
    
    return result;
}



@end
