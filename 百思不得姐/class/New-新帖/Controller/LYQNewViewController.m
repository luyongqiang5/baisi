//
//  LYQNewViewController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQNewViewController.h"

@implementation LYQNewViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏内容
    //设置导航栏的标题
    self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIamge:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    //设置背景色
    self.view.backgroundColor = LYQGlobalBg;
}
-(void)tagClick{
    LYQLogFunc;
    
}
@end
