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

#import "UIImage+myFilter.h"
#import "ImageFilterUtil.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize filterImage;
@synthesize scrollView;
@synthesize scrollFootView;


static NSString * const IMAGE_NAME = @"hito.jpg";


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.filterImage.image = [UIImage imageNamed:IMAGE_NAME];
    
    self.scrollView.contentSize = CGSizeMake(80, 40 * 21 + 5);
    self.scrollFootView.contentSize = CGSizeMake(75 * 5 + 5, 40);
    [self appendFilterButtonOnScrollView];
    [self appendFilterButtonOnScrollFootView];
    
    // カメラ
//    [self showCamera];
    
    
}

- (void)viewDidUnload
{
    [self setFilterImage:nil];
    [self setScrollView:nil];
    [self setScrollFootView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



// ボタン生成
// --下部スクロール
- (void)appendFilterButtonOnScrollFootView {
    int x = 75;
    int width =70;
    int height = 30;
    int fontSize = 11;
    
    
    UIButton *originalFootButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    originalFootButton.frame = CGRectMake(5, 5, width, height);
    [originalFootButton setTitle:@"Original" forState:UIControlStateNormal];
    [originalFootButton addTarget:self action:@selector(originalFootFilter:) forControlEvents:UIControlEventTouchUpInside];
    originalFootButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollFootView addSubview:originalFootButton];
    
    
    UIButton *grayFootButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    grayFootButton.frame = CGRectMake((1 * x) + 5, 5, width, height);
    [grayFootButton setTitle:@"Gray" forState:UIControlStateNormal];
    [grayFootButton addTarget:self action:@selector(grayFootFilter:) forControlEvents:UIControlEventTouchUpInside];
    grayFootButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollFootView addSubview:grayFootButton];
    
    
    UIButton *blurFootButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    blurFootButton.frame = CGRectMake((2 * x) + 5, 5, width, height);
    [blurFootButton setTitle:@"Blur" forState:UIControlStateNormal];
    [blurFootButton addTarget:self action:@selector(blurFootFilter:) forControlEvents:UIControlEventTouchUpInside];
    blurFootButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollFootView addSubview:blurFootButton];
    
    
    UIButton *mosaicFootButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    mosaicFootButton.frame = CGRectMake((3 * x) + 5, 5, width, height);
    [mosaicFootButton setTitle:@"Mosaic" forState:UIControlStateNormal];
    [mosaicFootButton addTarget:self action:@selector(mosaicFootFilter:) forControlEvents:UIControlEventTouchUpInside];
    mosaicFootButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollFootView addSubview:mosaicFootButton];
    
    UIButton *fishEyeFootButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    fishEyeFootButton.frame = CGRectMake((4 * x) + 5, 5, width, height);
    [fishEyeFootButton setTitle:@"FishEye" forState:UIControlStateNormal];
    [fishEyeFootButton addTarget:self action:@selector(fishEyeFootFilter:) forControlEvents:UIControlEventTouchUpInside];
    fishEyeFootButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollFootView addSubview:fishEyeFootButton];
    
}


// --右部スクロール
- (void)appendFilterButtonOnScrollView {
    int y = 40;
    int width =70;
    int height = 30;
    int fontSize = 11;
    
    UIButton *originalButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    originalButton.frame = CGRectMake(5, 5, width, height);
    [originalButton setTitle:@"Original" forState:UIControlStateNormal];
    [originalButton addTarget:self action:@selector(originalFilter:) forControlEvents:UIControlEventTouchUpInside];
    originalButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:originalButton];
    
    UIButton *monochromeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    monochromeButton.frame = CGRectMake(5, (1 * y) + 5, width, height);
    [monochromeButton setTitle:@"Monochrome" forState:UIControlStateNormal];
    [monochromeButton addTarget:self action:@selector(monochromeFilter:) forControlEvents:UIControlEventTouchUpInside];
    monochromeButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:monochromeButton];
    
    UIButton *monochrome2Button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    monochrome2Button.frame = CGRectMake(5, (2 * y) + 5, width, height);
    [monochrome2Button setTitle:@"Monochrome2" forState:UIControlStateNormal];
    [monochrome2Button addTarget:self action:@selector(monochrome2Filter:) forControlEvents:UIControlEventTouchUpInside];
    monochrome2Button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:monochrome2Button];
    
    UIButton *sepiaToneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sepiaToneButton.frame = CGRectMake(5, (3 * y) + 5, width, height);
    [sepiaToneButton setTitle:@"SepiaTone" forState:UIControlStateNormal];
    [sepiaToneButton addTarget:self action:@selector(sepiaToneFilter:) forControlEvents:UIControlEventTouchUpInside];
    sepiaToneButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:sepiaToneButton];
    
    UIButton *invertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    invertButton.frame = CGRectMake(5, (4 * y) + 5, width, height);
    [invertButton setTitle:@"Invert" forState:UIControlStateNormal];
    [invertButton addTarget:self action:@selector(invertFilter:) forControlEvents:UIControlEventTouchUpInside];
    invertButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:invertButton];
    
    UIButton *controlsButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    controlsButton.frame = CGRectMake(5, (5 * y) + 5, width, height);
    [controlsButton setTitle:@"Controls" forState:UIControlStateNormal];
    [controlsButton addTarget:self action:@selector(controlsFilter:) forControlEvents:UIControlEventTouchUpInside];
    controlsButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:controlsButton];
    
    UIButton *vignetteButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    vignetteButton.frame = CGRectMake(5, (6 * y) + 5, width, height);
    [vignetteButton setTitle:@"Vignette" forState:UIControlStateNormal];
    [vignetteButton addTarget:self action:@selector(vignetteFilter:) forControlEvents:UIControlEventTouchUpInside];
    vignetteButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:vignetteButton];
    
    UIButton *hueAdjustButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    hueAdjustButton.frame = CGRectMake(5, (7 * y) + 5, width, height);
    [hueAdjustButton setTitle:@"HueAdjust" forState:UIControlStateNormal];
    [hueAdjustButton addTarget:self action:@selector(hueAdjustFilter:) forControlEvents:UIControlEventTouchUpInside];
    hueAdjustButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:hueAdjustButton];
    
    UIButton *exposureAdjustButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    exposureAdjustButton.frame = CGRectMake(5, (8 * y) + 5, width, height);
    [exposureAdjustButton setTitle:@"ExposureAdjust" forState:UIControlStateNormal];
    [exposureAdjustButton addTarget:self action:@selector(exposureAdjustFilter:) forControlEvents:UIControlEventTouchUpInside];
    exposureAdjustButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:exposureAdjustButton];
    
    UIButton *highlightShadowAdjustButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    highlightShadowAdjustButton.frame = CGRectMake(5, (9 * y) + 5, width, height);
    [highlightShadowAdjustButton setTitle:@"HighlightShadowAdjust" forState:UIControlStateNormal];
    [highlightShadowAdjustButton addTarget:self action:@selector(highlightShadowAdjustFilter:) forControlEvents:UIControlEventTouchUpInside];
    highlightShadowAdjustButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:highlightShadowAdjustButton];
    
    UIButton *gammaAdjustButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    gammaAdjustButton.frame = CGRectMake(5, (10 * y) + 5, width, height);
    [gammaAdjustButton setTitle:@"GammaAdjust" forState:UIControlStateNormal];
    [gammaAdjustButton addTarget:self action:@selector(gammaAdjustFilter:) forControlEvents:UIControlEventTouchUpInside];
    gammaAdjustButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:gammaAdjustButton];
    
    UIButton *falseColorButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    falseColorButton.frame = CGRectMake(5, (11 * y) + 5, width, height);
    [falseColorButton setTitle:@"FalseColor" forState:UIControlStateNormal];
    [falseColorButton addTarget:self action:@selector(falseColorFilter:) forControlEvents:UIControlEventTouchUpInside];
    falseColorButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:falseColorButton];
    
    UIButton *vibranceButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    vibranceButton.frame = CGRectMake(5, (12 * y) + 5, width, height);
    [vibranceButton setTitle:@"Vibrance" forState:UIControlStateNormal];
    [vibranceButton addTarget:self action:@selector(vibranceFilter:) forControlEvents:UIControlEventTouchUpInside];
    vibranceButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:vibranceButton];
    
    UIButton *blurButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    blurButton.frame = CGRectMake(5, (13 * y) + 5, width, height);
    [blurButton setTitle:@"Blur" forState:UIControlStateNormal];
    [blurButton addTarget:self action:@selector(blurFilter:) forControlEvents:UIControlEventTouchUpInside];
    blurButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:blurButton];
    
    UIButton *equalizationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    equalizationButton.frame = CGRectMake(5, (14 * y) + 5, width, height);
    [equalizationButton setTitle:@"Equalization" forState:UIControlStateNormal];
    [equalizationButton addTarget:self action:@selector(equalizationFilter:) forControlEvents:UIControlEventTouchUpInside];
    equalizationButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:equalizationButton];
    
    UIButton *erodeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    erodeButton.frame = CGRectMake(5, (15 * y) + 5, width, height);
    [erodeButton setTitle:@"Erode" forState:UIControlStateNormal];
    [erodeButton addTarget:self action:@selector(erodeFilter:) forControlEvents:UIControlEventTouchUpInside];
    erodeButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:erodeButton];
    
    UIButton *dilateButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    dilateButton.frame = CGRectMake(5, (16 * y) + 5, width, height);
    [dilateButton setTitle:@"Dilate" forState:UIControlStateNormal];
    [dilateButton addTarget:self action:@selector(dilateFilter:) forControlEvents:UIControlEventTouchUpInside];
    dilateButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:dilateButton];
    
    UIButton *sharpenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sharpenButton.frame = CGRectMake(5, (17 * y) + 5, width, height);
    [sharpenButton setTitle:@"Sharpen" forState:UIControlStateNormal];
    [sharpenButton addTarget:self action:@selector(sharpenFilter:) forControlEvents:UIControlEventTouchUpInside];
    sharpenButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:sharpenButton];
    
    UIButton *edgeDetectionButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    edgeDetectionButton.frame = CGRectMake(5, (18 * y) + 5, width, height);
    [edgeDetectionButton setTitle:@"EdgeDetection" forState:UIControlStateNormal];
    [edgeDetectionButton addTarget:self action:@selector(edgeDetectionFilter:) forControlEvents:UIControlEventTouchUpInside];
    edgeDetectionButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:edgeDetectionButton];
    
    UIButton *embossButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    embossButton.frame = CGRectMake(5, (19 * y) + 5, width, height);
    [embossButton setTitle:@"Emboss" forState:UIControlStateNormal];
    [embossButton addTarget:self action:@selector(embossFilter:) forControlEvents:UIControlEventTouchUpInside];
    embossButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:embossButton];
    
    UIButton *heartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    heartButton.frame = CGRectMake(5, (20 * y) + 5, width, height);
    [heartButton setTitle:@"Heart" forState:UIControlStateNormal];
    [heartButton addTarget:self action:@selector(heartFilter:) forControlEvents:UIControlEventTouchUpInside];
    heartButton.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [self.scrollView addSubview:heartButton];
    
}



- (void)originalFootFilter:(id)sender {
    self.filterImage.image = [UIImage imageNamed:IMAGE_NAME];
}


- (void)grayFootFilter:(id)sender {
    UIImage *uiImage = [UIImage imageNamed:IMAGE_NAME];
    CGRect cgRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    self.filterImage.image = [uiImage gray:cgRect];
    
}

- (void)blurFootFilter:(id)sender {
    UIImage *uiImage = [UIImage imageNamed:IMAGE_NAME];
    CGRect cgRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    self.filterImage.image = [uiImage blur:cgRect nonBlurRange:0.9 xp:uiImage.size.width/2 yp:uiImage.size.height/2];
    
}

- (void)mosaicFootFilter:(id)sender {
    UIImage *uiImage = [UIImage imageNamed:IMAGE_NAME];
    CGRect cgRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    self.filterImage.image = [uiImage mosaic:cgRect size:2];
}

- (void)fishEyeFootFilter:(id)sender {
    UIImage *uiImage = [UIImage imageNamed:IMAGE_NAME];
    CGRect cgRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    self.filterImage.image = [uiImage fishEye:cgRect];
}

- (void)originalFilter:(id)sender {
    self.filterImage.image = [UIImage imageNamed:IMAGE_NAME];
}

- (void)monochromeFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterColorMonochrome:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)monochrome2Filter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterColorMonochrome2:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)sepiaToneFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterSepiaTone:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)invertFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterColorInvert:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)controlsFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterColorControls:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)vignetteFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterVignette:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)hueAdjustFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterHueAdjust:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)exposureAdjustFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterExposureAdjust:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)highlightShadowAdjustFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterHighlightShadowAdjust:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)gammaAdjustFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterGammaAdjust:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)falseColorFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterFalseColor:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)vibranceFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterVibrance:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)blurFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil blurIterations:3 image:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)equalizationFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterEqualization:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)erodeFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterErode:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)dilateFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterDilate:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)sharpenFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterSharpen:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)edgeDetectionFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterEdgeDetection:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)embossFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterEmboss:[UIImage imageNamed:IMAGE_NAME]];
}

- (void)heartFilter:(id)sender {
    self.filterImage.image = [ImageFilterUtil filterHeart:[UIImage imageNamed:IMAGE_NAME]];
}





// タッチした場所を中心にぼかす
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    NSInteger x = point.x/filterImage.frame.size.width*filterImage.image.size.width;
    NSInteger y = point.y/filterImage.frame.size.height*filterImage.image.size.height;
    
    filterImage.image = [[UIImage imageNamed:IMAGE_NAME] blur:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) nonBlurRange:2 xp:x yp:y];
    
}

// タッチしている場所を中心にぼかす
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    NSInteger x = point.x/filterImage.frame.size.width*filterImage.image.size.width;
    NSInteger y = point.y/filterImage.frame.size.height*filterImage.image.size.height;
    
    filterImage.image = [[UIImage imageNamed:IMAGE_NAME] blur:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) nonBlurRange:2 xp:x yp:y];

}





//- (void)showCamera {
//    // デバイスにカメラ付いてるかチェック
//    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
//        NSLog(@"カメラないよ");
//        return;
//    }
//    
//    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//    
//    // ソースをカメラに指定
//    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
//    imagePickerController.delegate = self;
//    // 編集を許可するかしないか。デフォルトはNO
//    imagePickerController.allowsEditing = YES;
//    // カメラ表示
//    [self presentModalViewController:imagePickerController animated:YES];
//}
//
//// === UIPickerControllerDelegate =============
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
//    // cancel押したとき
//    // モーダルビュー消します
//    [self dismissModalViewControllerAnimated:YES];
//}
//
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
//    //　useが押されたときはimageやらeditingInfoやらを引き連れて帰ってきます。おかえり。
//    [self dismissModalViewControllerAnimated:YES];
//    // 撮った写真を使います
//    filterImage.image = image;
//}


@end
