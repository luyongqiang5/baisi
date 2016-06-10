//
//  LYQRecommendViewController.m
//  百思不得姐
//
//  Created by ma c on 16/5/27.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "LYQRecommendCategoryCell.h"
#import <MJExtension.h>
#import "LYQRecommendCategory.h"
#import "LYQRecommendUserCell.h"
#import "LYQRecommendUser.h"
#import <MJRefresh.h>

#define LYQSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface LYQRecommendViewController () <UITableViewDataSource, UITableViewDelegate>
/** 左边的类别数据 */
@property (nonatomic, strong) NSArray *categories;

///** 右边的用户数据 */
//@property (nonatomic, strong) NSArray *users;

/** 左边的类别表格 */
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
/** 右边的用户表格 */
@property (weak, nonatomic) IBOutlet UITableView *userTableView;
/** 请求参数 */
@property (nonatomic, strong) NSMutableDictionary *params;

/** AFN请求管理者 */
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation LYQRecommendViewController

static NSString * const LYQCategoryId = @"category";
static NSString * const LYQUserId = @"user";

- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 控件的初始化
    [self setupTableView];
    
    // 添加刷新控件
    [self setupRefresh];
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        LYQLog(@"%@",responseObject);//显示数据
        //隐藏指示器
        [SVProgressHUD dismiss];
        //服务器返回的JSON数据 objectArrayWithKeyValuesArray
        self.categories = [LYQRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        //刷新表格
        [self.categoryTableView reloadData];
        //默认选中首行
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:(UITableViewScrollPositionTop)];
        // 让用户表格进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //隐藏指示器
        [SVProgressHUD dismiss];
        //显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败"];
    }];
}

- (void)setupTableView
{
    // 注册
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYQRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:LYQCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYQRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:LYQUserId];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // 设置标题
    self.title = @"推荐关注";
    
    // 设置背景色
    self.view.backgroundColor = LYQGlobalBg;
}

/**
 * 添加刷新控件
 */
- (void)setupRefresh
{
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    
//    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - 加载用户数据
- (void)loadNewUsers
{
    LYQRecommendCategory *rc = LYQSelectedCategory;
    
    // 设置当前页码为1
    rc.currentPage = 1;
    
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPage);
    self.params = params;
    // 发送请求给服务器, 加载右侧的数据
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [LYQRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 清除所有旧数据
        [rc.users removeAllObjects];
        
        // 添加到当前类别对应的用户数组中
        [rc.users addObjectsFromArray:users];
        
        // 保存总数
        rc.total = [responseObject[@"total"] integerValue];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        
        // 结束刷新
        [self.userTableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreUsers
{
    LYQRecommendCategory *category = LYQSelectedCategory;
    
    // 发送请求给服务器, 加载右侧的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPage);
    self.params = params;
    
    [self.manager GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 字典数组 -> 模型数组
        NSArray *users = [LYQRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // 添加到当前类别对应的用户数组中
        [category.users addObjectsFromArray:users];
        
        // 不是最后一次请求
        if (self.params != params) return;
        
        // 刷新右边的表格
        [self.userTableView reloadData];
        
        // 让底部控件结束刷新
        [self checkFooterState];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (self.params != params) return;
        
        // 提醒
        [SVProgressHUD showErrorWithStatus:@"加载用户数据失败"];
        
        // 让底部控件结束刷新
        [self.userTableView.mj_footer endRefreshing];
    }];
}

/**
 * 时刻监测footer的状态
 */
- (void)checkFooterState
{
    LYQRecommendCategory *rc = LYQSelectedCategory;
    
    // 每次刷新右边数据时, 都控制footer显示或者隐藏
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // 让底部控件结束刷新
    if (rc.users.count == rc.total) { // 全部数据已经加载完毕
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // 还没有加载完毕
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        return self.categories.count;
    } else { // 右边的用户表格
        [self checkFooterState];
        LYQRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.categoryTableView) { // 左边的类别表格
        LYQRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:LYQCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // 右边的用户表格
        LYQRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:LYQUserId];
        LYQRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 结束刷新
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
    LYQRecommendCategory *c = self.categories[indexPath.row];
    if (c.users.count) {
        // 显示曾经的数据
        [self.userTableView reloadData];
    } else {
        // 赶紧刷新表格,目的是: 马上显示当前category的用户数据, 不让用户看见上一个category的残留数据
        [self.userTableView reloadData];
        //进入下拉刷新状态
        [self.userTableView.mj_header beginRefreshing];
//        // 发送请求给服务器, 加载右侧的数据
//        NSMutableDictionary * params = [NSMutableDictionary dictionary];
//        params[@"a"]= @"list";
//        params[@"c"]= @"subscribe";
//        params[@"category_id"]= @(c.id);
//        [[AFHTTPSessionManager manager]GET:@"https://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSArray *users = [LYQRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
//            [c.users addObjectsFromArray:users];
//            //刷新表格
//            [self.userTableView reloadData];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            LYQLog(@"%@",error);
//        }];
    }
    
}

#pragma mark - 控制器的销毁
- (void)dealloc
{
    // 停止所有操作
    [self.manager.operationQueue cancelAllOperations];
}

/**
 1.目前只能显示1页数据
 
 3.网络慢带来的细节问题
 */
/*
 错误描述：
 
 App Transport Security has blocked a cleartext HTTP (http://) resource load since it is insecure. Temporary exceptions can be configured via your app‘s Info.plist file.
 在iOS9 beta中，苹果将原http协议改成了https协议，使用 TLS1.2 SSL加密请求数据。
 
 解决方法：
 
 在info.plist 加入key
 
 <key>NSAppTransportSecurity</key>
 <dict>
 <key>NSAllowsArbitraryLoads</key>
 <true/>
 </dict>
 参考资料:
https://developer.apple.com/library/prerelease/ios/releasenotes/General/WhatsNewIniOS/Articles/iOS9.html#//apple_ref/doc/uid/TP40016198-DontLinkElementID_13
 */
@end

