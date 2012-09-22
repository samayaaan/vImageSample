//
//  UIImage+myFilter.m
//  vImageSample
//
//  Created by masaya ito on 12/09/22.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import "UIImage+myFilter.h"

@implementation UIImage (Effect)

// ぼかし
-(UIImage*)blur:(CGRect)rect nonBlurRange:(NSInteger)nonBlurRange xp:(NSUInteger)xp yp:(NSInteger)yp {
	// CGImageを取得する
	CGImageRef cgImage;
	cgImage = self.CGImage;
    
	// 画像情報を取得する
	size_t width;
	size_t height;
	size_t bitsPerComponent;
	size_t bitsPerPixel;
	size_t bytesPerRow;
	CGColorSpaceRef colorSpace;
	CGBitmapInfo bitmapInfo;
	bool shouldInterpolate;
	CGColorRenderingIntent intent;
	width = CGImageGetWidth(cgImage);
	height = CGImageGetHeight(cgImage);
	bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
	bitsPerPixel = CGImageGetBitsPerPixel(cgImage);
	bytesPerRow = CGImageGetBytesPerRow(cgImage);
	colorSpace = CGImageGetColorSpace(cgImage);
	bitmapInfo = CGImageGetBitmapInfo(cgImage);
	shouldInterpolate = CGImageGetShouldInterpolate(cgImage);
	intent = CGImageGetRenderingIntent(cgImage);
    
	// データプロバイダを取得する
	CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
    
	if (rect.size.width + rect.origin.x  > width) {
		rect.size.width = width - rect.origin.x;
	}
	if (rect.size.height + rect.origin.y > height) {
		rect.size.height = height - rect.origin.y;
	}
    
    
	// ビットマップデータを取得する
	CFDataRef data = CGDataProviderCopyData(dataProvider);
	UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
	// ビットマップに効果を与える(ここしか違わないのでまとめるべき)
    
	NSInteger i, j;
    NSInteger x, y;
	for (j = rect.origin.y ; j < rect.origin.y + rect.size.height; j++)
	{
		for (i = rect.origin.x; i < rect.origin.x + rect.size.width; i++)
		{
            
            NSUInteger count=0;
            NSUInteger rr=0, gg=0, bb=0;
            
            
//            if(j==0){
//                NSLog(@"j:%d", j);
//                NSLog(@"i:%d", i);
//            
//                
//                NSLog(@"xxxx:%f", abs(i-xp)/self.size.width);
//            NSLog(@"xxxxx:%f", abs(i-xp)/self.size.width*);
//            }
            
            NSInteger range = sqrt(pow(abs(i-xp)/self.size.width*10,2)
                         + pow(abs(j-yp)/self.size.height*10,2));
            if(range < nonBlurRange){
                range = 0;
            }
            
            // 周囲の情報を取得
            for(y = j-range; y <= j+range; y++){
                
                for(x = i-range; x <= i+range; x++){
                    
                    // 指定範囲外は対象としない
                    
//                    if(j==0){
//                        NSLog(@"y:%d", y);
//                        NSLog(@"x:%d", x);
//                    }
                    
                    
                    if(rect.origin.y <= y && y < rect.origin.y + rect.size.height
                       && rect.origin.x <= x && x < rect.origin.x + rect.size.width){
                        
                        
                        // ピクセルのポインタを取得する
                        UInt8* tmp = buffer + y * bytesPerRow + x * 4;
                        
                        // RGBの値を取得する
                        rr += *(tmp + 0);
                        gg += *(tmp + 2);
                        bb += *(tmp + 1);
                        
                        count++;
//                        if(j==0){
//                        NSLog(@"count:%d", count);
//                        }
                    }
                }
            }
            
            // ピクセルのポインタを取得する
            UInt8* tmp = buffer + j * bytesPerRow + i * 4;
			// 輝度の値をRGB値として設定する
			*(tmp + 0) = rr/count;
			*(tmp + 2) = gg/count;
			*(tmp + 1) = bb/count;
            
		}
    }
    
	// 効果を与えたデータを作成する
	CFDataRef effectedData;
	effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
	// 効果を与えたデータプロバイダを作成する
	CGDataProviderRef effectedDataProvider;
	effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
	// 画像を作成する
	CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage* effectedImage = [UIImage imageWithCGImage:effectedCgImage];
    
    
	// 作成したデータを解放する
	CGImageRelease(effectedCgImage);
	CFRelease(effectedDataProvider);
	CFRelease(effectedData);
	CFRelease(data);
    
	return effectedImage;
}


// モザイク
-(UIImage*)mosaic:(CGRect)rect size:(NSUInteger)size {
	// CGImageを取得する
	CGImageRef cgImage;
	cgImage = self.CGImage;
    
	// 画像情報を取得する
	size_t width;
	size_t height;
	size_t bitsPerComponent;
	size_t bitsPerPixel;
	size_t bytesPerRow;
	CGColorSpaceRef colorSpace;
	CGBitmapInfo bitmapInfo;
	bool shouldInterpolate;
	CGColorRenderingIntent intent;
	width = CGImageGetWidth(cgImage);
	height = CGImageGetHeight(cgImage);
	bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
	bitsPerPixel = CGImageGetBitsPerPixel(cgImage);
	bytesPerRow = CGImageGetBytesPerRow(cgImage);
	colorSpace = CGImageGetColorSpace(cgImage);
	bitmapInfo = CGImageGetBitmapInfo(cgImage);
	shouldInterpolate = CGImageGetShouldInterpolate(cgImage);
	intent = CGImageGetRenderingIntent(cgImage);
    
	// データプロバイダを取得する
	CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
    
	if (rect.size.width + rect.origin.x  > width) {
		rect.size.width = width - rect.origin.x;
	}
	if (rect.size.height + rect.origin.y > height) {
		rect.size.height = height - rect.origin.y;
	}
    
    
	// ビットマップデータを取得する
	CFDataRef data = CGDataProviderCopyData(dataProvider);
	UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
	// ビットマップに効果を与える(ここしか違わないのでまとめるべき)
    
	NSUInteger i, j, k, l;

    
	for (l = rect.origin.y ; l < rect.origin.y + rect.size.height; l += size)
	{
		for (k = rect.origin.x; k < rect.origin.x + rect.size.width; k += size)
		{
            NSUInteger rr=0, gg=0, bb=0;
            for (j = l ; j < l + size; j++)
            {
                for (i = k; i < k + size; i++)
                {
                    // ピクセルのポインタを取得する
                    UInt8 *tmp = buffer + j * bytesPerRow + i * 4;
                    
                    // RGBの値を取得する
                    rr += *(tmp + 0);
                    gg += *(tmp + 2);
                    bb += *(tmp + 1);
                    
                    
                }
            }
            NSUInteger count = (i-k) * (j-l);
            
            for (j = l ; j < l + size; j++)
            {
                for (i = k; i < k + size; i++)
                {
                    // ピクセルのポインタを取得する
                    UInt8* tmp = buffer + j * bytesPerRow + i * 4;
                    
                    // RGBの値を取得する
                    
                    *(tmp + 0) = rr/count;
                    *(tmp + 2) = gg/count;
                    *(tmp + 1) = bb/count;
                    
                }
            }
        }
    }
    
	// 効果を与えたデータを作成する
	CFDataRef effectedData;
	effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
	// 効果を与えたデータプロバイダを作成する
	CGDataProviderRef effectedDataProvider;
	effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
	// 画像を作成する
	CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage* effectedImage = [UIImage imageWithCGImage:effectedCgImage];
    
    
	// 作成したデータを解放する
	CGImageRelease(effectedCgImage);
	CFRelease(effectedDataProvider);
	CFRelease(effectedData);
	CFRelease(data);
    
	return effectedImage;
}

// グレースケール
-(UIImage*)gray:(CGRect)rect {
	// CGImageを取得する
	CGImageRef cgImage;
	cgImage = self.CGImage;
    
	// 画像情報を取得する
	size_t width;
	size_t height;
	size_t bitsPerComponent;
	size_t bitsPerPixel;
	size_t bytesPerRow;
	CGColorSpaceRef colorSpace;
	CGBitmapInfo bitmapInfo;
	bool shouldInterpolate;
	CGColorRenderingIntent intent;
	width = CGImageGetWidth(cgImage);
	height = CGImageGetHeight(cgImage);
	bitsPerComponent = CGImageGetBitsPerComponent(cgImage);
	bitsPerPixel = CGImageGetBitsPerPixel(cgImage);
	bytesPerRow = CGImageGetBytesPerRow(cgImage);
	colorSpace = CGImageGetColorSpace(cgImage);
	bitmapInfo = CGImageGetBitmapInfo(cgImage);
	shouldInterpolate = CGImageGetShouldInterpolate(cgImage);
	intent = CGImageGetRenderingIntent(cgImage);
    
	// データプロバイダを取得する
	CGDataProviderRef dataProvider = CGImageGetDataProvider(cgImage);
    
	if (rect.size.width + rect.origin.x  > width) {
		rect.size.width = width - rect.origin.x;
	}
	if (rect.size.height + rect.origin.y > height) {
		rect.size.height = height - rect.origin.y;
	}
    
    
	// ビットマップデータを取得する
	CFDataRef data = CGDataProviderCopyData(dataProvider);
	UInt8* buffer = (UInt8*)CFDataGetBytePtr(data);
    
	// ビットマップに効果を与える(ここしか違わないのでまとめるべき)
    
	NSUInteger i, j;
	for (j = rect.origin.y ; j < rect.origin.y + rect.size.height; j++)
	{
		for (i = rect.origin.x; i < rect.origin.x + rect.size.width; i++)
		{
			// ピクセルのポインタを取得する
			UInt8* tmp = buffer + j * bytesPerRow + i * 4;
            
			// RGBの値を取得する
			UInt8 r, g, b;
			r = *(tmp + 0);
			g = *(tmp + 2);
			b = *(tmp + 1);
            
			// 輝度値を計算する
			UInt8 y = (0.3 * r + 0.59 * g + 0.11 * b);
            
			// 輝度の値をRGB値として設定する
			*(tmp + 0) = y;//r
			*(tmp + 2) = y;//g
			*(tmp + 1) = y;//b
            
		}
    }
    
	// 効果を与えたデータを作成する
	CFDataRef effectedData;
	effectedData = CFDataCreate(NULL, buffer, CFDataGetLength(data));
    
	// 効果を与えたデータプロバイダを作成する
	CGDataProviderRef effectedDataProvider;
	effectedDataProvider = CGDataProviderCreateWithCFData(effectedData);
    
	// 画像を作成する
	CGImageRef effectedCgImage = CGImageCreate(
                                               width, height,
                                               bitsPerComponent, bitsPerPixel, bytesPerRow,
                                               colorSpace, bitmapInfo, effectedDataProvider,
                                               NULL, shouldInterpolate, intent);
    
    UIImage* effectedImage = [UIImage imageWithCGImage:effectedCgImage];

    
	// 作成したデータを解放する
	CGImageRelease(effectedCgImage);
	CFRelease(effectedDataProvider);
	CFRelease(effectedData);
	CFRelease(data);
    
	return effectedImage;
}

@end