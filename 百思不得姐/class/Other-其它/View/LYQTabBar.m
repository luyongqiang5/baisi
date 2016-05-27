//
//  LYQTabBar.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQTabBar.h"
@interface LYQTabBar()
/** 发布按钮 */
@property (weak,nonatomic) UIButton          * publishButton;
@end

@implementation LYQTabBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //设置TabBar的背景图片
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
        //添加发布按钮
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateSelected)];
        
        publishButton.size = publishButton.currentBackgroundImage.size;
        
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //设置发布按钮的frame
//    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
//    self.publishButton.size = self.publishButton.currentBackgroundImage.size;

    self.publishButton.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    NSInteger index = 0;
//    CGFloat buttonW = self.frame.size.width / 5;
    for (UIView *button in self.subviews) {
        if(![button isKindOfClass:NSClassFromString(@"UITabBarButton")])continue;
        
        CGFloat buttonX = self.frame.size.width/5 * ((index>1)?(index +1):index);
        button.frame = CGRectMake(
                                  buttonX,
                                  0,
                                  self.frame.size.width / 5,
                                  self.frame.size.height
                                  );
        index++;
    }
}

@end
