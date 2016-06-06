//
//  LYQPushGuideView.m
//  百思不得姐
//
//  Created by ma c on 16/6/4.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQPushGuideView.h"

@implementation LYQPushGuideView


+ (instancetype)guideView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
}

+ (void)show{
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults]stringForKey:key];

    //判断当前版本与以前版本是否相同，不相同显示，相同不显示
    #warning Version Equal?
    if (![currentVersion isEqualToString: sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        LYQPushGuideView *guideView = [LYQPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)close {
    [self removeFromSuperview];
}

@end
