//
//  LYQPublishViewController.m
//  百思不得姐
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQPublishViewController.h"
#import "LYQVerticalButton.h"
#import <POP.h>
#import <SVProgressHUD.h>
@interface LYQPublishViewController ()

@end

@implementation LYQPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 点击事件失效
    self.view.userInteractionEnabled = NO;
    // 数据
    NSArray *images = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    
    // 中间的6个按钮
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (LYQScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat xMargin = (LYQScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1);
    for (int i = 0; i<images.count; i++) {
        LYQVerticalButton *button = [[LYQVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        // 设置内容
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // 计算X,Y
        int row = i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (xMargin + buttonW);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - LYQScreenH;
        
        // 按钮动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = 10;
        anim.springSpeed = 10;
        anim.beginTime = CACurrentMediaTime() + 0.1 * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = LYQScreenW * 0.5;
    CGFloat centerEndY = LYQScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - LYQScreenH;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.beginTime = CACurrentMediaTime() + images.count * 0.1;
    anim.springBounciness = 10;
    anim.springSpeed = 10;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 标语动画执行完毕, 恢复点击事件
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button
{
    [self cancelWithCompletionBlock:^{
        if (button.tag == 0) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@暂不能用",button.titleLabel.text]];
        } else if (button.tag == 1) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@暂不能用",button.titleLabel.text]];
        }
        else if (button.tag == 2) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@暂不能用",button.titleLabel.text]];
        }
        else if (button.tag == 3) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@暂不能用",button.titleLabel.text]];
        }
        else if (button.tag == 4) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@暂不能用",button.titleLabel.text]];
        }
        else if (button.tag == 5) {
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@暂不能用",button.titleLabel.text]];
        }
    }];
}

/**
 * 先执行退出动画, 动画完毕后执行completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock
{
    // 让控制器的view不能被点击
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i<self.view.subviews.count; i++) {
        UIView *subview = self.view.subviews[i];
        
        // 基本动画
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subview.centerY + LYQScreenH;
        // 动画的执行节奏(一开始很慢, 后面很快)
        //        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subview.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * 0.1;
        [subview pop_addAnimation:anim forKey:nil];
        
        // 监听最后一个动画
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                // 执行传进来的completionBlock参数
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancel];
}

@end
