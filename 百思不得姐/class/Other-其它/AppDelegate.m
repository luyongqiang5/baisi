//
//  AppDelegate.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "AppDelegate.h"
#import "LYQTabBarController.h"
#import "LYQPushGuideView.h"

#import "LYQEssenceController.h"
#import "LYQFriendTrendsViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //创建窗口
    self.window = [[UIWindow alloc]init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //设置窗口 的跟控制器
    LYQTabBarController * tabBarcontroller = [[LYQTabBarController alloc]init];
    
    self.window.rootViewController = tabBarcontroller;
    //显示窗口
    [self.window makeKeyAndVisible];
    // 显示推送引导
    [LYQPushGuideView show];
 
    /**
     type 该item 唯一标识符
     localizedTitle ：标题
     localizedSubtitle：副标题
     icon：icon图标 可以使用系统类型 也可以使用自定义的图片
     userInfo：用户信息字典 自定义参数，完成具体功能需求
     */
    UIApplicationShortcutIcon *essenceIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabBar_essence_icon"];
    UIApplicationShortcutItem *essenceItem = [[UIApplicationShortcutItem alloc] initWithType:@"item1" localizedTitle:@"精华" localizedSubtitle:@"" icon:essenceIcon userInfo:nil];
    UIApplicationShortcutIcon *newIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabBar_new_icon"];
    UIApplicationShortcutItem *newItem = [[UIApplicationShortcutItem alloc] initWithType:@"item2" localizedTitle:@"新帖" localizedSubtitle:@"" icon:newIcon userInfo:nil];
    UIApplicationShortcutIcon *friendTrendsIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabBar_friendTrends_icon"];
    UIApplicationShortcutItem *friendTrendsItem = [[UIApplicationShortcutItem alloc] initWithType:@"item3" localizedTitle:@"关注" localizedSubtitle:@"" icon:friendTrendsIcon userInfo:nil];
    UIApplicationShortcutIcon *MeIcon = [UIApplicationShortcutIcon iconWithTemplateImageName:@"tabBar_me_icon"];
    UIApplicationShortcutItem *MeItem = [[UIApplicationShortcutItem alloc] initWithType:@"item4" localizedTitle:@"我" localizedSubtitle:@"" icon:MeIcon userInfo:nil];
    /** 将items 添加到app图标 */
    application.shortcutItems = @[essenceItem,newItem,friendTrendsItem,MeItem];
    
    
    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler{
    UITabBarController *tabBarVC = (UITabBarController *)self.window.rootViewController;
    if([shortcutItem.type isEqualToString:@"item1"]){
            tabBarVC.selectedIndex = 0;
        }else if ([shortcutItem.type isEqualToString:@"item2"]){
            tabBarVC.selectedIndex = 1;
        }else if ([shortcutItem.type isEqualToString:@"item3"]){
            tabBarVC.selectedIndex = 2;
        }else if ([shortcutItem.type isEqualToString:@"item4"]){
            tabBarVC.selectedIndex = 3;
        }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
