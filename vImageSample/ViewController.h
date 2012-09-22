//
//  ViewController.h
//  vImageSample
//
//  Created by masaya ito on 12/09/19.
//  Copyright (c) 2012年 mIto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *filterImage;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

- (IBAction)originalAction:(id)sender;
- (IBAction)monoAction:(id)sender;
- (IBAction)blurAction:(id)sender;
- (IBAction)mosaicAction:(id)sender;
- (IBAction)blur2Action:(id)sender;

@end
