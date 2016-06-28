//
//  LYQTopicVoiceView.m
//  百思不得姐
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQTopicVoiceView.h"
#import "LYQTopic.h"
#import <UIImageView+WebCache.h>
#import "LYQShowPictureViewController.h"
@interface LYQTopicVoiceView()//voicelength   playcount
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *playcountLabel;
@property (weak, nonatomic) IBOutlet UILabel *voicetime;


@end


@implementation LYQTopicVoiceView
/**显示xib 把xib用起来*/
+(instancetype)voiceView{
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
    // 图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image]];
    
    // 播放次数
    self.playcountLabel.text = [NSString stringWithFormat:@"%zd播放", topic.playcount];
    
    // 时长
    NSInteger minute = topic.voicetime / 60;
    NSInteger second = topic.voicetime % 60;
    self.voicetime.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
