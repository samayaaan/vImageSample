//
//  UIImage+myFilter.h
//  vImageSample
//
//  Created by masaya ito on 12/09/22.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (effect)


-(UIImage*)blur:(CGRect)rect nonBlurRange:(NSInteger)nonBlurRange xp:(NSUInteger)xp yp:(NSInteger)yp ;
-(UIImage*)mosaic:(CGRect)rect size:(NSUInteger)size;
-(UIImage*)gray:(CGRect)rect;

@end
