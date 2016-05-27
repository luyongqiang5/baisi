//
//  LYQFriendTrendsViewController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQFriendTrendsViewController.h"
#import "LYQRecommendViewController.h"
@implementation LYQFriendTrendsViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    //设置导航栏内容 
    //设置导航栏的标题
    self.navigationItem.title = @"我的关注";
    //设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIamge:@"friendsRecommentIcon"highImage:@"friendsRecommentIcon-click" target:self action:@selector(friendsRecommentClick)];
    //设置背景色
    self.view.backgroundColor = LYQGlobalBg;
}
-(void)friendsRecommentClick{
    LYQRecommendViewController *vc = [[LYQRecommendViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
