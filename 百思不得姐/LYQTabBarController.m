//
//  LYQTabBarController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQTabBarController.h"

@implementation LYQTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    //添加子控制器
    UIViewController *vc1 = [[UIViewController alloc]init];
    vc1.tabBarItem.title = @"精华";
    //修改字体属性
    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
    arrts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    arrts[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [vc1.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
    NSMutableDictionary *selecteArrts = [NSMutableDictionary dictionary];
    selecteArrts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selecteArrts[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc1.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
    
    //去掉图片被蓝色渲染 （或在图片框中自己调 ：属性-》Render As-> Origian Image）
//    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc1.tabBarItem.selectedImage = image;
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    vc1.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc1];
    
    UIViewController *vc2 = [[UIViewController alloc]init];
    vc2.tabBarItem.title = @"新帖";
    //修改字体属性
    [vc2.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
    [vc2.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
    
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    vc2.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc2];
    
    UIViewController *vc3 = [[UIViewController alloc]init];
    vc3.tabBarItem.title = @"关注";
    //修改字体属性
    [vc3.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
    [vc3.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
    
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    vc3.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc3];
    
    UIViewController *vc4 = [[UIViewController alloc]init];
    vc4.tabBarItem.title = @"我";
    //修改字体属性
    [vc4.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
    [vc4.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
    
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc4.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:vc4];
}

@end
