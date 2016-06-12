//
//  LYQTopicCell.m
//  百思不得姐
//
//  Created by ma c on 16/6/10.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQTopicCell.h"
#import "LYQTopic.h"
#import <UIImageView+WebCache.h>

@interface LYQTopicCell()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/**新浪加V认证*/
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;

@end

@implementation LYQTopicCell


- (void)awakeFromNib
{
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

-(void)setTopic:(LYQTopic *)topic{
    _topic = topic;
    //测试新浪加V
//    topic.sina_v = arc4random_uniform(100)%2;
    //新浪加V
    self.sinaVView.hidden = !topic.isSina_v;
    // 设置头像
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image]  placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    // 设置名字
    self.nameLabel.text = topic.name;
    // 设置帖子的创建时间
    self.createTimeLabel.text = topic.create_time;
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
//        [self testDate:topic.create_time];^^^^
}
//关于时间的代码，这个项目中不用 ^^^^
- (void)testDate:(NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    // 当前时间
//    NSDate *now = [NSDate date];
    // 发帖时间
//    NSDate *create = [fmt dateFromString:create_time];
    
//    LYQLog(@"%@", [now deltaFrom:create]);
    
    //    // 日历
    //    NSCalendar *calendar = [NSCalendar currentCalendar];
    //
    //    // 比较时间
    //    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //    NSDateComponents *cmps = [calendar components:unit fromDate:create toDate:now options:0];
    //
    //    LYQLog(@"%@ %@", create, now);
    //    LYQLog(@"%zd %zd %zd %zd %zd %zd", cmps.year, cmps.month, cmps.day, cmps.hour, cmps.minute, cmps.second);
    
    // 获得NSDate的每一个元素
    //    NSInteger year = [calendar component:NSCalendarUnitYear fromDate:now];
    //    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:now];
    //    NSInteger day = [calendar component:NSCalendarUnitDay fromDate:now];
    //    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:now];
    //    LYQLog(@"%zd %zd %zd", cmps.year, cmps.month, cmps.day);
//}

//- (void)testDate:(NSString *)create_time
//{
//    // 当前时间
//    NSDate *now = [NSDate date];
//
//    // 发帖时间
//    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
//    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
//    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
//    NSDate *create = [fmt dateFromString:create_time];
//    NSTimeInterval delta = [now timeIntervalSinceDate:create];
//}
//}
}
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

-(void)setFrame:(CGRect)frame{
    static CGFloat margin = 10;
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.origin.y += margin;
    frame.size.height -= margin;
    [super setFrame:frame];
}

@end
