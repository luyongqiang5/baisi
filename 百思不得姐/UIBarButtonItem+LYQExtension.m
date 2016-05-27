//
//  UIBarButtonItem+LYQExtension.m
//  百思不得姐
//
//  Created by ma c on 16/5/27.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "UIBarButtonItem+LYQExtension.h"

@implementation UIBarButtonItem (LYQExtension)

+(instancetype)itemWithIamge:(NSString *)image highImage:(NSString *)highImage target:(id)targer action:(SEL)action{
    //设置导航栏的按钮
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [button setBackgroundImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:(UIControlStateHighlighted)];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:targer action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    return [[self alloc]initWithCustomView:button];
}

@end
