//
//  LYQTabBarController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQTabBarController.h"
#import "LYQEssenceController.h"
#import "LYQNewViewController.h"
#import "LYQFriendTrendsViewController.h"
#import "LYQMeViewController.h"
#import "LYQTabBar.h"
#import "LYQNavigationController.h"
@implementation LYQTabBarController

+(void)initialize{
    //通过appearance统一设置所有UITabBarItem的文字属性
    //    方法后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
    arrts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    arrts[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    
    NSMutableDictionary *selecteArrts = [NSMutableDictionary dictionary];
    selecteArrts[NSFontAttributeName] = arrts[NSFontAttributeName];
    selecteArrts[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
    [item setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    //去掉图片被蓝色渲染 （或在图片框中自己调 ：属性-》Render As-> Origian Image）
    //    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    vc1.tabBarItem.selectedImage = image;
    //添加子控制器
    [self setupChildVc:[[LYQEssenceController alloc]init] andTitle:@"精华" andImage:@"tabBar_essence_icon" andSelectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[LYQNewViewController alloc]init] andTitle:@"新帖" andImage:@"tabBar_new_icon" andSelectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[LYQFriendTrendsViewController alloc]init] andTitle:@"关注" andImage:@"tabBar_friendTrends_icon" andSelectedImage:@"tabBar_friendTrends_click_icon"];
    [self setupChildVc:[[LYQMeViewController alloc]init] andTitle:@"我" andImage:@"tabBar_me_icon" andSelectedImage:@"tabBar_me_click_icon"];
    //更换TabBar
    [self setValue:[[LYQTabBar alloc]init] forKey:@"tabBar"];
    
    
//    UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:(UIControlStateNormal)];
//    [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:(UIControlStateSelected)];
//    publishButton.bounds = CGRectMake(0, 0, publishButton.currentBackgroundImage.size.width, publishButton.currentBackgroundImage.size.height);
//    
//    publishButton.center = CGPointMake(self.tabBar.frame.size.width*0.5, self.tabBar.frame.size.height*0.5);
//    [self.tabBar addSubview:publishButton];

}
/**
 *  初始化子控制器
 */
-(void)setupChildVc:(UIViewController *)vc andTitle:(NSString *)title andImage:(NSString *)image andSelectedImage:(NSString *)selectedImage{
    //设置文字和图片
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];;
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    //随机背景色(在这里设置颜色会程序一启动直接创建四个控制器  so不要在这里设置)
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100)/100.0 green:arc4random_uniform(100)/100.0 blue:arc4random_uniform(100)/100.0 alpha:1.0];
    
//    [self addChildViewController:vc];
    //包装一个导航控制器，添加导航控制器为tabbarcontroller的子控制器
    LYQNavigationController *nav = [[LYQNavigationController alloc]initWithRootViewController:vc];
    
//    vc.navigationItem.title = title;
    [self addChildViewController:nav];
}

//-(void)viewDidLoad{
//    [super viewDidLoad];
//    //通过appearance统一设置所有UITabBarItem的文字属性
////    方法后面带有UI_APPEARANCE_SELECTOR的方法，都可以通过appearance对象来统一设置
//    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
//    arrts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    arrts[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    
//    NSMutableDictionary *selecteArrts = [NSMutableDictionary dictionary];
//    selecteArrts[NSFontAttributeName] = arrts[NSFontAttributeName];
//    selecteArrts[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    
//    UITabBarItem *item = [UITabBarItem appearance];
//    [item setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
//    
//    [item setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
//    
//    
//    //添加子控制器
//    UIViewController *vc1 = [[UIViewController alloc]init];
//    vc1.tabBarItem.title = @"精华";
//    
//    //去掉图片被蓝色渲染 （或在图片框中自己调 ：属性-》Render As-> Origian Image）
//    //    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    //    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    //    vc1.tabBarItem.selectedImage = image;
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    vc1.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc1];
//    
//    UIViewController *vc2 = [[UIViewController alloc]init];
//    vc2.tabBarItem.title = @"新帖";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//    vc2.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc2];
//    
//    UIViewController *vc3 = [[UIViewController alloc]init];
//    vc3.tabBarItem.title = @"关注";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    vc3.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc3];
//    
//    UIViewController *vc4 = [[UIViewController alloc]init];
//    vc4.tabBarItem.title = @"我";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
//    vc4.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc4];
//}
//-(void)viewDidLoad{
//    [super viewDidLoad];
//    //添加子控制器
//    UIViewController *vc1 = [[UIViewController alloc]init];
//    vc1.tabBarItem.title = @"精华";
//    //修改字体属性
//    NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
//    arrts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    arrts[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
//    [vc1.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
//    NSMutableDictionary *selecteArrts = [NSMutableDictionary dictionary];
//    selecteArrts[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    selecteArrts[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
//    [vc1.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
//    
//    //去掉图片被蓝色渲染 （或在图片框中自己调 ：属性-》Render As-> Origian Image）
////    UIImage *image = [UIImage imageNamed:@"tabBar_essence_click_icon"];
////    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
////    vc1.tabBarItem.selectedImage = image;
//    vc1.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
//    vc1.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc1];
//    
//    UIViewController *vc2 = [[UIViewController alloc]init];
//    vc2.tabBarItem.title = @"新帖";
//    //修改字体属性
//    [vc2.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
//    [vc2.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
//    
//    vc2.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
//    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
//    vc2.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc2];
//    
//    UIViewController *vc3 = [[UIViewController alloc]init];
//    vc3.tabBarItem.title = @"关注";
//    //修改字体属性
//    [vc3.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
//    [vc3.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
//    
//    vc3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
//    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
//    vc3.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc3];
//    
//    UIViewController *vc4 = [[UIViewController alloc]init];
//    vc4.tabBarItem.title = @"我";
//    //修改字体属性
//    [vc4.tabBarItem setTitleTextAttributes:arrts forState:(UIControlStateNormal)];
//    [vc4.tabBarItem setTitleTextAttributes:selecteArrts forState:(UIControlStateSelected)];
//    
//    vc4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
//    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
//    vc4.view.backgroundColor = [UIColor redColor];
//    [self addChildViewController:vc4];
//}

@end
