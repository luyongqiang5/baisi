//
//  LYQTopicPictureView.m
//  百思不得姐
//
//  Created by ma c on 16/6/15.
//  Copyright © 2016年 Lu. All rights reserved.
// DACircular Progress

#import "LYQTopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "LYQTopic.h"
#import "LYQShowPictureViewController.h"
#import "LYQProgressView.h"
@interface LYQTopicPictureView ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
/**
 *  gif
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**
 *  查看大图
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigButton;
/** 进度条控件*/
@property (weak, nonatomic) IBOutlet LYQProgressView *progressView;

@end

@implementation LYQTopicPictureView

+(instancetype)pictureView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}
//如果发现定义的size与想要的size不一样，改这个
-(void)awakeFromNib{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    //给图片添加监听器 Interaction:互动 Enabled:激活
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showPicture)]];
}

- (void)showPicture
{
    LYQShowPictureViewController *showPicture = [[LYQShowPictureViewController alloc]init];
    showPicture.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

-(void)setTopic:(LYQTopic *)topic{
    _topic = topic;
    //立马显示最新的进度值（防止因为网速慢，导致显示的是其他图片的进度值）
    [self.progressView setProgress:topic.pictureProgress animated:NO];
    // 设置图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        //计算进度值
        topic.pictureProgress = 1.0 * receivedSize / expectedSize;
        //显示进度值
        [self.progressView setProgress:topic.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
        // 如果是大图片, 才需要进行绘图处理
        if (topic.isBigPicture == NO) return;
        
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.pictureF.size, YES, 0.0);
        
        // 将下载完的image对象绘制到图形上下文
        CGFloat width = topic.pictureF.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // 获得图片
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // 结束图形上下文
        UIGraphicsEndImageContext();
}];
    //判断gif显示还是隐藏
    NSString *extension = topic.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // 判断是否显示"点击查看全图"
    if (topic.isBigPicture) { // 大图
        self.seeBigButton.hidden = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // 非大图
        self.seeBigButton.hidden = YES;
        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
