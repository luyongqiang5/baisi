//
//  LYQMeViewController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQMeViewController.h"

@implementation LYQMeViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏内容 mine-setting-icon-click  mine-sun-icon-click
    //设置导航栏的标题
    self.navigationItem.title = @"我的";
    //设置导航栏右边的按钮
    self.navigationItem.rightBarButtonItems = @[
        [UIBarButtonItem itemWithIamge:@"mine-setting-icon" highImage:@"mine-setting-icon-click" target:self action:@selector(mineButtonClick)],
        [UIBarButtonItem itemWithIamge:@"mine-moon-icon" highImage:@"mine-moon-icon-click" target:self action:@selector(mineMoonButtonClick)]
                                                ];
}

-(void)mineButtonClick{
    LYQLogFunc;
}
-(void)mineMoonButtonClick{
    LYQLogFunc;
}
@end
