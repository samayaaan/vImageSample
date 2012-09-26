//
//  ViewController.h
//  vImageSample
//
//  Created by masaya ito on 12/09/19.
//  Copyright (c) 2012年 mIto. All rights reserved.
//f

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *filterImage;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollFootView;
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end
