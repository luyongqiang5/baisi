//
//  LYQTopic.h
//  百思不得姐
//
//  Created by ma c on 16/6/8.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYQTopic : NSObject
{
    CGFloat _cellHeight;
}
/************************************************/
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 发帖时间 */
@property (nonatomic, copy) NSString *create_time;
/** 文字内容 */
@property (nonatomic, copy) NSString *text;
/** 顶的数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩的数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发的数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论的数量 */
@property (nonatomic, assign) NSInteger comment;
/** 图片的宽 */
@property (nonatomic, assign) CGFloat              width;
/** 图片的高 */
@property (nonatomic, assign) CGFloat              height;
/** 小图 */
@property (nonatomic, copy) NSString          * small_image;
/** 中图 */
@property (nonatomic, copy) NSString          * middle_image;
/** 大图 */
@property (nonatomic, copy) NSString          * large_image;
/** 帖子的类型 */
@property (nonatomic, assign) LYQTopicType          type;
/** 音频时长 */
@property (nonatomic, assign) NSInteger             voicetime;
/** 视频时长 */
@property (nonatomic, assign) NSInteger             videotime;
/** 播放次数 */
@property (nonatomic, assign) NSInteger              playcount;

/** 是否为新浪的加V用户 */
@property (nonatomic, assign, getter=isSina_v) BOOL              sina_v;
/************************************************/
/** cell高度 */
@property (nonatomic, assign,readonly) CGFloat              cellHeight;
/** 图片控件的frame */
@property (nonatomic, assign, readonly) CGRect pictureF;
/** 图片是否太大 */
@property (nonatomic, assign, getter=isBigPicture) BOOL bigPicture;

/** 声音控件的frame */
@property (nonatomic, assign, readonly) CGRect voiceF;

/** 视频控件的frame */
@property (nonatomic, assign, readonly) CGRect videoF;

/** 图片的下载进度 */
@property (nonatomic, assign) CGFloat pictureProgress;
/**
 *  @property默认自动生成get,set方法，当你写get,set方法后不会自动生成成员变量了
 *  当使用readonly时，不会自动生成set方法，当你重写get方法后不会自动生成成员变量了，要自己加上
 */


@end
