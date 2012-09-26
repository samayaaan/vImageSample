//
//  ImageFilterUtil.m
//  vImageSample
//
//  Created by masaya ito on 12/09/26.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <Accelerate/Accelerate.h>
#import "ImageFilterUtil.h"

@implementation ImageFilterUtil


static uint8_t backgroundColorBlack[4] = {0, 0, 0, 0};

static int16_t gaussianblur_kernel[25] = {
    1, 4, 6, 4, 1,
    4, 16, 24, 16, 4,
    6, 24, 36, 24, 6,
    4, 16, 24, 16, 4,
    1, 4, 6, 4, 1
};

static unsigned char morphological_kernel[9] = {
    1, 1, 1,
    1, 1, 1,
    1, 1, 1,
};

static int16_t sharpen_kernel[9] = {
    -1, -1, -1,
    -1, 9, -1,
    -1, -1, -1
};

static int16_t edgedetect_kernel[9] = {
    -1, -1, -1,
    -1, 8, -1,
    -1, -1, -1
};

static int16_t emboss_kernel[9] = {
    -2, 0, 0,
    0, 1, 0,
    0, 0, 2
};


+ (UIImage *)filterColorMonochrome:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorMonochrome" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputColor", [CIColor colorWithRed:0.75 green:0.75 blue:0.75], //パラメータ
                          @"inputIntensity", [NSNumber numberWithFloat:1.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterColorMonochrome2:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorMonochrome" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputColor", [CIColor colorWithRed:0.75 green:0.75 blue:0.75], //パラメータ
                          @"inputIntensity", [NSNumber numberWithFloat:7.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterSepiaTone:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CISepiaTone" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputIntensity", [NSNumber numberWithFloat:2.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterColorInvert:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorInvert" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterColorControls:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIColorControls" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputSaturation", [NSNumber numberWithFloat:1.0], //パラメータ
                          @"inputBrightness", [NSNumber numberWithFloat:0.5], //パラメータ
                          @"inputContrast", [NSNumber numberWithFloat:3.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterVignette:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIVignette" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputIntensity", [NSNumber numberWithFloat:4.0], //パラメータ
                          @"inputRadius", [NSNumber numberWithFloat:10.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterHueAdjust:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIHueAdjust" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputAngle", [NSNumber numberWithFloat:3.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterExposureAdjust:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIExposureAdjust" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputEV", [NSNumber numberWithFloat:3.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterHighlightShadowAdjust:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIHighlightShadowAdjust" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputHighlightAmount", [NSNumber numberWithFloat:1.0], //パラメータ
                          @"inputShadowAmount", [NSNumber numberWithFloat:1.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterGammaAdjust:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIGammaAdjust" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputPower", [NSNumber numberWithFloat:3.0], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterFalseColor:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIFalseColor" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputColor0", [CIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0], //パラメータ
                          @"inputColor1", [CIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:0.7], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)filterVibrance:(UIImage *)effectedImage {
    CIImage *ciImage = [[CIImage alloc] initWithImage:effectedImage]; //ファイル名
    CIFilter *ciFilter = [CIFilter filterWithName:@"CIVibrance" //フィルター名
                                    keysAndValues:kCIInputImageKey, ciImage,
                          @"inputAmount", [NSNumber numberWithFloat:-1], //パラメータ
                          nil];
    CIContext *ciContext = [CIContext contextWithOptions:nil];
    CGImageRef cgimg = [ciContext createCGImage:[ciFilter outputImage] fromRect:[[ciFilter outputImage] extent]];
    UIImage *tmpImage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(cgimg);
    
    return tmpImage;
}

+ (UIImage *)blurIterations:(int)iterations image:(UIImage *)image {
    
    for (int i = 0; i < iterations; i++) {
        image = [self filterBlur:image];
    }
    return image;
}

+ (UIImage *)filterBlur:(UIImage *)effectedImage {
    const size_t width = (size_t const) effectedImage.size.width;
    const size_t height = (size_t const) effectedImage.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect) {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, effectedImage.CGImage);
    
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void *outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    
    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, gaussianblur_kernel, 5, 5, 256, NULL, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    free(outt);
    
    CGImageRef blurredImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *blurred = [UIImage imageWithCGImage:blurredImageRef scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(blurredImageRef);
    CGContextRelease(bmContext);
    
    return blurred;
}

+ (UIImage *)filterEqualization:(UIImage *)effectedImage {
    const size_t width = (size_t const) effectedImage.size.width;
    const size_t height = (size_t const) effectedImage.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect) {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, effectedImage.CGImage);
    
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    
    vImageEqualization_ARGB8888(&src, &dest, kvImageNoFlags);
    
    CGImageRef destImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *destImage = [UIImage imageWithCGImage:destImageRef scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(destImageRef);
    CGContextRelease(bmContext);
    
    return destImage;
}

+ (UIImage *)erodeWithIterations:(int)iterations image:(UIImage *)image {
    
    for (int i = 0; i < iterations; i++) {
        image = [self filterErode:image];
    }
    return image;
}

+ (UIImage *)filterErode:(UIImage *)effectedImage {
    const size_t width = (size_t const) effectedImage.size.width;
    const size_t height = (size_t const) effectedImage.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect) {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, effectedImage.CGImage);
    
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void *outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    
    vImageErode_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef erodedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *eroded = [UIImage imageWithCGImage:erodedImageRef scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(erodedImageRef);
    CGContextRelease(bmContext);
    
    return eroded;
}

+ (UIImage *)dilateWithIterations:(int)iterations image:(UIImage *)image {
    
    for (int i = 0; i < iterations; i++) {
        image = [self filterDilate:image];
    }
    return image;
}

+ (UIImage *)filterDilate:(UIImage *)effectedImage {
    const size_t width = (size_t const) effectedImage.size.width;
    const size_t height = (size_t const) effectedImage.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect) {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, effectedImage.CGImage);
    
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void *outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageDilate_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef dilatedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *dilated = [UIImage imageWithCGImage:dilatedImageRef scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(dilatedImageRef);
    CGContextRelease(bmContext);
    
    return dilated;
}

+ (UIImage *)filterSharpen:(UIImage *)effectedImage {
    const size_t width = (size_t const) effectedImage.size.width;
    const size_t height = (size_t const) effectedImage.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect) {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, effectedImage.CGImage);
    
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void *outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, sharpen_kernel, 3, 3, 1, NULL, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef sharpenedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *sharpened = [UIImage imageWithCGImage:sharpenedImageRef scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(sharpenedImageRef);
    CGContextRelease(bmContext);
    
    return sharpened;
}

+ (UIImage *)filterEdgeDetection:(UIImage *)effectedImage {
    const size_t width = (size_t const) effectedImage.size.width;
    const size_t height = (size_t const) effectedImage.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect) {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, effectedImage.CGImage);
    
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void *outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    
    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, edgedetect_kernel, 3, 3, 1, backgroundColorBlack, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    CGImageRef edgedImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *edged = [UIImage imageWithCGImage:edgedImageRef scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(edgedImageRef);
    free(outt);
    CGContextRelease(bmContext);
    
    return edged;
}

+ (UIImage *)filterEmboss:(UIImage *)effectedImage {
    const size_t width = (size_t const) effectedImage.size.width;
    const size_t height = (size_t const) effectedImage.size.height;
    const size_t bytesPerRow = width * 4;
    
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!bmContext)
        return nil;
    
    CGContextDrawImage(bmContext, (CGRect) {.origin.x = 0.0f, .origin.y = 0.0f, .size.width = width, .size.height = height}, effectedImage.CGImage);
    
    UInt8 *data = (UInt8 *) CGBitmapContextGetData(bmContext);
    if (!data) {
        CGContextRelease(bmContext);
        return nil;
    }
    
    const size_t n = sizeof(UInt8) * width * height * 4;
    void *outt = malloc(n);
    vImage_Buffer src = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    
    vImageConvolve_ARGB8888(&src, &dest, NULL, 0, 0, emboss_kernel, 3, 3, 1, NULL, kvImageCopyInPlace);
    
    memcpy(data, outt, n);
    
    free(outt);
    
    CGImageRef embossImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *emboss = [UIImage imageWithCGImage:embossImageRef scale:1.0f orientation:UIImageOrientationUp];
    
    CGImageRelease(embossImageRef);
    CGContextRelease(bmContext);
    
    return emboss;
}

+ (UIImage *)filterHeart:(UIImage *)effectedImage {
    
    UIImage *heart = [UIImage imageNamed:@"heart.png"];
    
    UIGraphicsBeginImageContext(CGSizeMake(effectedImage.size.width, effectedImage.size.height));
    [effectedImage drawAtPoint:CGPointMake(0, 0)];
    [heart drawAtPoint:CGPointMake(0, 0)];
    UIImage *tmpImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tmpImage;
}

@end
