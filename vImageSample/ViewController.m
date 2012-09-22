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

@interface ViewController ()

@end

@implementation ViewController
@synthesize filterImage;


static NSString * const IMAGE_NAME = @"wallpaper.jpg";


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    filterImage.image = [UIImage imageNamed:IMAGE_NAME];
    
    // カメラ
//    [self showCamera];
    
    
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

// 元画像
- (IBAction)originalAction:(id)sender {
    filterImage.image = [UIImage imageNamed:IMAGE_NAME];
    
}

// 自作モノクロ
- (IBAction)monoAction:(id)sender {
    
//    filterImage.image = [filterImage.image grayscale];
//    filterImage.image = [filterImage.image autoEnhance];
    
    filterImage.image = [filterImage.image gray:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height)];
    
    
}

// maskを使った無理矢理ぼかし
- (IBAction)blurAction:(id)sender {
    
    filterImage.image = [filterImage.image maskWithImage:[UIImage imageNamed:@"mask.png"]];
    filterImage.image = [filterImage.image gaussianBlurWithBias:0];
    filterImage.image = [filterImage.image gaussianBlurWithBias:0];

    filterImage.image = [filterImage.image gaussianBlurWithBias:0];
    
    filterImage.image = [filterImage.image gaussianBlurWithBias:0];

    
    UIGraphicsBeginImageContext(CGSizeMake(filterImage.image.size.width, filterImage.image.size.height));
    [[UIImage imageNamed:IMAGE_NAME] drawInRect:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height)];
    [filterImage.image drawInRect:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height)];
    UIImage *image_c = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    filterImage.image = image_c;
    
}

// 自作モザイク
- (IBAction)mosaicAction:(id)sender {
    
    filterImage.image = [filterImage.image mosaic:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) size:10];
}

// 自作ぼかし
- (IBAction)blur2Action:(id)sender {
    
    filterImage.image = [filterImage.image blur:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) nonBlurRange:1 xp:filterImage.image.size.width/2 yp:filterImage.image.size.height/2];
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
