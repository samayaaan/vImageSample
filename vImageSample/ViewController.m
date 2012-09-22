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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    filterImage.image = [UIImage imageNamed:@"sample_10s.jpg"];
    
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    NSInteger x = point.x/filterImage.frame.size.width*filterImage.image.size.width;
    NSInteger y = point.y/filterImage.frame.size.height*filterImage.image.size.height;
    
    filterImage.image = [[UIImage imageNamed:@"sample_10s.jpg"] blur:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) nonBlurRange:2 xp:x yp:y];
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    NSInteger x = point.x/filterImage.frame.size.width*filterImage.image.size.width;
    NSInteger y = point.y/filterImage.frame.size.height*filterImage.image.size.height;
    
    filterImage.image = [[UIImage imageNamed:@"sample_10s.jpg"] blur:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) nonBlurRange:2 xp:x yp:y];

}


- (IBAction)originalAction:(id)sender {
    filterImage.image = [UIImage imageNamed:@"sample_10s.jpg"];
    
}

- (IBAction)monoAction:(id)sender {
    
//    filterImage.image = [filterImage.image grayscale];
//    filterImage.image = [filterImage.image autoEnhance];
    
    filterImage.image = [filterImage.image gray:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height)];
    
    
}

- (IBAction)blurAction:(id)sender {
    
    filterImage.image = [filterImage.image maskWithImage:[UIImage imageNamed:@"mask.png"]];
    filterImage.image = [filterImage.image gaussianBlurWithBias:0];
    filterImage.image = [filterImage.image gaussianBlurWithBias:0];

    filterImage.image = [filterImage.image gaussianBlurWithBias:0];
    
    filterImage.image = [filterImage.image gaussianBlurWithBias:0];

    
    UIGraphicsBeginImageContext(CGSizeMake(167, 223));
    [[UIImage imageNamed:@"sample_10s.jpg"] drawInRect:CGRectMake(0, 0, 167, 223)];
    [filterImage.image drawInRect:CGRectMake(0, 0, 167, 223)];
    UIImage *image_c = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    filterImage.image = image_c;
    
}

- (IBAction)mosaicAction:(id)sender {
    
    filterImage.image = [filterImage.image mosaic:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) size:3];
}

- (IBAction)blur2Action:(id)sender {
    
    filterImage.image = [filterImage.image blur:CGRectMake(0, 0, filterImage.image.size.width, filterImage.image.size.height) nonBlurRange:1 xp:60 yp:100];
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
