//
//  LYQEssenceController.m
//  百思不得姐
//
//  Created by ma c on 16/5/26.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQEssenceController.h"
#import "LYQRecommendTagsViewController.h"

#import "LYQAllViewController.h"
#import "LYQVideoViewController.h"
#import "LYQVoiceViewController.h"
#import "LYQPictureViewController.h"
#import "LYQWordViewController.h"


@interface LYQEssenceController ()<UIScrollViewDelegate>
/** 标签栏底部的红色指示器 */
@property (nonatomic, weak) UIView *indicatorView;
/** 当前选中的按钮 */
@property (nonatomic, weak) UIButton *selectedButton;
/** 顶部的所有标签 */
@property (nonatomic, weak) UIView *titlesView;
/** 底部的所有内容 */
@property (nonatomic, weak) UIScrollView *contentView;
@end

@implementation LYQEssenceController

-(void)viewDidLoad{
    [super viewDidLoad];
    // 设置导航栏
    [self setupNav];
    // 初始化子控制器
    [self setupChildVces];
    // 设置顶部的标签栏
    [self setupTitlesView];
    // 底部的scrollView
    [self setupContentView];
}

/**
 * 初始化子控制器
 */
- (void)setupChildVces
{
    LYQWordViewController *word = [[LYQWordViewController alloc] init];
    
    
    
    LYQAllViewController *all = [[LYQAllViewController alloc] init];
    all.title = @"全部";
    all.type = LYQTopicTypeAll;//帖子数据的类型
    [self addChildViewController:all];
    
    LYQVoiceViewController *voice = [[LYQVoiceViewController alloc] init];
    voice.title = @"声音";
    voice.type = LYQTopicTypeVoice;
    [self addChildViewController:voice];
    
    LYQVideoViewController *video = [[LYQVideoViewController alloc] init];
    video.title = @"视频";
    video.type = LYQTopicTypeVideo;
    [self addChildViewController:video];
    
    LYQPictureViewController *picture = [[LYQPictureViewController alloc] init];
    picture.title = @"图片";
    picture.type = LYQTopicTypePicture;
    [self addChildViewController:picture];
    
    word.title = @"段子";
    word.type = LYQTopicTypeWord;//帖子数据的类型
    [self addChildViewController:word];
}

-(void)setupTitlesView{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = LYQTitilesViewH;
    titlesView.y = LYQTitilesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    // 内部的子标签
//    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i<self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
        
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
        
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
    [titlesView addSubview:indicatorView];
    
}
//
- (void)titleClick:(UIButton *)button{
    // 修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    //动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
/**
 * 底部的scrollView
 */
- (void)setupContentView{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * contentView = [[UIScrollView alloc]init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添加第一个控制器的view
    [self scrollViewDidEndScrollingAnimation:contentView];
    //使图层垫底
//    [self.view insertSubview:contentView atIndex:0];
}
/**
 设置导航栏
 */
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
#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // 设置控制器view的y值为0(默认是20)
    vc.view.height = scrollView.height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
   /*子控制器不一定是UITableViewController，所以要放在各个控制器中
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    */
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
