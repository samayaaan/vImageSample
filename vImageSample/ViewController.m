//
//  ViewController.m
//  vImageSample
//
//  Created by masaya ito on 12/09/19.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize filterImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    filterImage.image = [UIImage imageNamed:@"sample_10s.jpg"];
    
}

- (void)viewDidUnload
{
    [self setFilterImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)monoAction:(id)sender {
    // CIColorMonochrome
    CIImage *monoCIImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"sample_10s.jpg"]]; //ファイル名
    CIFilter *monoCIFilter = [CIFilter filterWithName:@"CIColorMonochrome" //フィルター名
                                        keysAndValues:kCIInputImageKey, monoCIImage,
                              @"inputColor", [CIColor colorWithRed:0.75 green:0.75 blue:0.75], //パラメータ
                              @"inputIntensity", [NSNumber numberWithFloat:1.0], //パラメータ
                              nil
                              ];
    CIContext *monoCIContext = [CIContext contextWithOptions:nil];
    CGImageRef monoCGImage = [monoCIContext createCGImage:[monoCIFilter outputImage] fromRect:[[monoCIFilter outputImage] extent]];
    UIImage *monoUIImage = [UIImage imageWithCGImage:monoCGImage scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(monoCGImage);
    
    filterImage.image = monoUIImage;
    
    // TODO mIto 再度押下したら元画像に戻ると良い
    
    
    
    // CIGaussianBlur blur系はiOS5はサポートしていない模様
    // http://stackoverflow.com/questions/8528726/does-ios-5-support-blur-coreimage-fiters
    CIImage *blurCIImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"sample_10s.jpg"]];
    
    CIFilter *blurCIFilter = [CIFilter filterWithName:@"CIMedianFilter" keysAndValues:kCIInputImageKey, blurCIImage,
                              @"inputRadius", [NSNumber numberWithFloat:1.0], nil];
    
    
    CIContext *blurCIContext = [CIContext contextWithOptions:nil];
    CGImageRef blurCGImage = [blurCIContext createCGImage:[blurCIFilter outputImage] fromRect:[[blurCIFilter outputImage] extent]];
    UIImage *blurUIImage = [UIImage imageWithCGImage:blurCGImage scale:1.0f orientation:UIImageOrientationUp];
    CGImageRelease(blurCGImage);
}
@end
