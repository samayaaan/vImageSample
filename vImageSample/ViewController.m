//
//  ViewController.m
//  vImageSample
//
//  Created by masaya ito on 12/09/19.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Blurring.h"
#import "UIImage+Filtering.h"
#import "UIImage+Masking.h"
#import "UIImage+Enhancing.h"
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

- (IBAction)originalAction:(id)sender {
    filterImage.image = [UIImage imageNamed:@"sample_10s.jpg"];
}

- (IBAction)monoAction:(id)sender {
    
    filterImage.image = [filterImage.image grayscale];
//    filterImage.image = [filterImage.image autoEnhance];
//    filterImage.image = [filterImage.image maskWithImage:[UIImage imageNamed:@"sample_10s.jpg"]];
    
}

- (IBAction)blurAction:(id)sender {
    filterImage.image = [filterImage.image gaussianBlurWithBias:0];
}
@end
