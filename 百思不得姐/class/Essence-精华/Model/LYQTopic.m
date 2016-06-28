//
//  LYQTopic.m
//  百思不得姐
//
//  Created by ma c on 16/6/8.
//  Copyright © 2016年 Lu. All rights reserved.
//

/**
 今年
    今天
        1分钟内
            刚刚
        1小时内
            xx分钟前
        其他
            xx小时前
    昨天
        昨天 18:56:34
    其他
        06-23 19:56:23
 
 非今年
 2014-05-08 18:45:30
 */



#import "LYQTopic.h"
#import <MJExtension.h>
@implementation LYQTopic

{
//    CGRect _pictureF;
}

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"small_image":@"image0",
             @"large_image":@"image1",
             @"middle_image":@"image2",
             };
}

- (NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create = [fmt dateFromString:_create_time];
    
    if (create.isThisYear) { // 今年
        if (create.isToday) { // 今天
            NSDateComponents *cmps = [[NSDate date] deltaFrom:create];
            
            if (cmps.hour >= 1) { // 时间差距 >= 1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1) { // 1小时 > 时间差距 >= 1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else { // 1分钟 > 时间差距
                return @"刚刚";
            }
        } else if (create.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm:ss";
            return [fmt stringFromDate:create];
        } else { // 其他
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:create];
        }
    } else { // 非今年
        return _create_time;
    }
}

-(CGFloat)cellHeight{
    if (!_cellHeight) {
        // 文字的最大尺寸
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LYQTopicCellMargin, MAXFLOAT);
        
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        
        // cell的高度
        _cellHeight= LYQTopicCellTextY + textH + LYQTopicCellBottomBarH + 2 * LYQTopicCellMargin;
        //根据帖子的类型处理cell的高度
        if(self.type == LYQTopicTypePicture){//图片
            //显示图片的宽度
            CGFloat pictureW = maxSize.width;
            //显示图片的高度
            CGFloat pictureH = self.height / self.width * pictureW;
            if (pictureH >= XMGTopicCellPictureMaxH) { // 图片高度过长
                pictureH = XMGTopicCellPictureBreakH;
                self.bigPicture = YES; // 大图
            }
            // 计算图片控件的frame
            CGFloat pictureX = LYQTopicCellMargin;
            CGFloat pictureY = LYQTopicCellTextY + textH + LYQTopicCellMargin;
            _pictureF = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            _cellHeight += pictureH + LYQTopicCellMargin;
        }else if (self.type == LYQTopicTypeVoice){//声音
            CGFloat voiceX = LYQTopicCellMargin;
            CGFloat voiceY = LYQTopicCellTextY + textH + LYQTopicCellMargin;
            CGFloat voiceW = maxSize.width;
            CGFloat voiceH = self.height / self.width * voiceW;
            _voiceF = CGRectMake(voiceX, voiceY, voiceW, voiceH);
            _cellHeight += voiceH + LYQTopicCellMargin;
        }else if (self.type == LYQTopicTypeVideo){//视频
            CGFloat videoX = LYQTopicCellMargin;
            CGFloat videoY = LYQTopicCellTextY + textH + LYQTopicCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = self.height / self.width * videoW;
            _videoF = CGRectMake(videoX, videoY, videoW, videoH);
            _cellHeight += videoH + LYQTopicCellMargin;
        }
        
        
    }
    return _cellHeight;
}

@end
