//
//  ImageFilterUtil.h
//  vImageSample
//
//  Created by masaya ito on 12/09/26.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageFilterUtil : NSObject

+(UIImage *)filterColorMonochrome:(UIImage *)effectedImage;
+(UIImage *)filterColorMonochrome2:(UIImage *)effectedImage;
+(UIImage *)filterSepiaTone:(UIImage *)effectedImage;

+(UIImage *)filterColorInvert:(UIImage *)effectedImage;

+(UIImage *)filterColorControls:(UIImage *)effectedImage;

+(UIImage *)filterVignette:(UIImage *)effectedImage;

+(UIImage *)filterHueAdjust:(UIImage *)effectedImage;

+ (UIImage *)filterExposureAdjust:(UIImage *)effectedImage;

+ (UIImage *)filterHighlightShadowAdjust:(UIImage *)effectedImage;

+ (UIImage *)filterGammaAdjust:(UIImage *)effectedImage;

+ (UIImage *)filterFalseColor:(UIImage *)effectedImage;

+ (UIImage *)filterVibrance:(UIImage *)effectedImage;

+ (UIImage *)blurIterations:(int)iterations image:(UIImage *)image;

+ (UIImage *)filterBlur:(UIImage *)effectedImage;

+ (UIImage *)filterEqualization:(UIImage *)effectedImage;

+ (UIImage *)erodeWithIterations:(int)iterations image:(UIImage *)image;

+ (UIImage *)filterErode:(UIImage *)effectedImage;

+ (UIImage *)dilateWithIterations:(int)iterations image:(UIImage *)image;

+ (UIImage *)filterDilate:(UIImage *)effectedImage;

+(UIImage *)filterSharpen:(UIImage *)effectedImage;

+ (UIImage *)filterEdgeDetection:(UIImage *)effectedImage;

+ (UIImage *)filterEmboss:(UIImage *)effectedImage;

+ (UIImage *)filterHeart:(UIImage *)effectedImage;


@end