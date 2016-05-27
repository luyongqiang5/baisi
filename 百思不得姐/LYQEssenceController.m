//
//  LYQEssenceController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQEssenceController.h"

@implementation LYQEssenceController
-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏内容
    //设置导航栏的标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
//    UIButton *tagButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:(UIControlStateNormal)];
//    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:(UIControlStateHighlighted)];
//    tagButton.size = tagButton.currentBackgroundImage.size;
//    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:(UIControlEventTouchUpInside)];

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIamge:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem alloc]initWithTitle:@"文字" style:<#(UIBarButtonItemStyle)#> target:<#(nullable id)#> action:<#(nullable SEL)#>
}
-(void)tagClick{
    LYQLogFunc;
    
}

@end
