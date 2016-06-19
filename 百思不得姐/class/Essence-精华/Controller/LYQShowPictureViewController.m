//
//  LYQShowPictureViewController.m
//  百思不得姐
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQShowPictureViewController.h"
#import "LYQTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "LYQProgressView.h"
@interface LYQShowPictureViewController ()
@property (weak, nonatomic) IBOutlet LYQProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) UIImageView *imageView;
@end

@implementation LYQShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 屏幕尺寸
//    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
//    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    // 添加图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW = LYQScreenW;
    CGFloat pictureH = pictureW * self.topic.height / self.topic.width;
    if (pictureH > LYQScreenH) { // 图片显示高度超过一个屏幕, 需要滚动查看
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = LYQScreenH * 0.5;
    }
    
    // 马上显示当前图片的下载进度
    [self.progressView setProgress:self.topic.pictureProgress animated:YES];
    
    // 下载图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        [self.progressView setProgress:1.0 * receivedSize / expectedSize animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片并没下载完毕!"];
        return;
    }
    
    // 将图片写入相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"保存成功!"];
    }
}


@end
