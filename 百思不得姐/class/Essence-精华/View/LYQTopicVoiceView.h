//
//  LYQTopicVoiceView.h
//  百思不得姐
//
//  Created by ma c on 16/6/28.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LYQTopic;
@interface LYQTopicVoiceView : UIView
/**显示xib 把xib用起来*/
+(instancetype)voiceView;


/** 帖子 */
@property (nonatomic, strong) LYQTopic            * topic;
@end
