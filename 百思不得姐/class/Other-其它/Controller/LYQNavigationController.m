//
//  LYQNavigationController.m
//  百思不得姐
//
//  Created by ma c on 16/5/27.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQNavigationController.h"

@interface LYQNavigationController ()

@end

@implementation LYQNavigationController

/**
 *  当第一次使用这个类的时候会调用
 */
+(void)initialize{
    //设置导航控制器的图片
    //当导航栏用在LYQNavigationController中，appearance设置才会生效
//    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//     UINavigationBar *bar = [UINavigationBar new];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]  forBarMetrics:UIBarMetricsDefault];
//    LYQLogFunc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航控制器的图片
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"]  forBarMetrics:UIBarMetricsDefault];
    //整个项目的导航控制器的图片一样 不管用不用这个分类
//    UINavigationBar *bar = [UINavigationBar appearance];
//    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count>0) {
        UIButton *button = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [button setTitle:@"返回" forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:(UIControlStateNormal)];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:(UIControlStateHighlighted)];
        button.size = CGSizeMake(70, 30);
        //让按钮内部的所有内容左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        //根据内容调整按钮的大小
//        [button sizeToFit];
        //将按钮的内容向左移
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        [button addTarget:self action:@selector(back) forControlEvents:(UIControlEventTouchUpInside)];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
        //隐藏TabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
    
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:(UIBarButtonItemStyleDone) target:nil action:nil];
}

-(void)back{
    [self popViewControllerAnimated:YES];
}

@end
