//
//  LYQEssenceController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQEssenceController.h"
#import "LYQRecommendTagsViewController.h"

@interface LYQEssenceController ()
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
@end

@implementation LYQEssenceController

-(void)viewDidLoad{
    [super viewDidLoad];
    // 设置导航栏
    [self setupNav];
    // 设置顶部的标签栏
    [self setupTitlesView];
}

-(void)setupTitlesView{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    // 内部的子标签
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height = height;
        button.width = width;
        button.x = i * width;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    };
    
}
//
- (void)titleClick:(UIButton *)button{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
}
// 设置导航栏
-(void)setupNav{
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
    //设置导航栏左边的按钮文字
    //    self.navigationItem.leftBarButtonItem = [UIBarButtonItem alloc]initWithTitle:@"文字" style:(UIBarButtonItemStyle) target:(nullable id) action:(nullable SEL)
    
    //设置背景色
    self.view.backgroundColor = LYQGlobalBg;
}

-(void)tagClick{
    LYQRecommendTagsViewController *tags = [[LYQRecommendTagsViewController alloc]init];
    [self.navigationController pushViewController:tags animated:YES];
    
}

@end
