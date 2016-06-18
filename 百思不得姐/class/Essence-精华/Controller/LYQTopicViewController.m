//
//  LYQTopicViewController.m
//  百思不得姐
//
//  Created by ma c on 16/6/12.
//  Copyright © 2016年 Lu. All rights reserved.
//


#import "LYQTopicViewController.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "LYQTopic.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "LYQTopicCell.h"



@interface LYQTopicViewController ()
/** 帖子数据 */
@property (nonatomic, strong) NSMutableArray            * topics;
/** 当前页码 */
@property (nonatomic, assign) NSInteger                   page;
/** 当加载下一页数据时需要这个参数 */
@property (nonatomic, copy) NSString                    * maxtime;
/** 上一次的请求参数 */
@property (nonatomic, strong) NSDictionary              * params;
@end

@implementation LYQTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化表格
    [self setupTableView];
    // 添加刷新控件
    [self setupRefresh];
}
static NSString * const LYQTopicCellId = @"topic";
- (void)setupTableView
{
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = LYQTitilesViewY + LYQTitilesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYQTopicCell class]) bundle:nil] forCellReuseIdentifier:LYQTopicCellId];
}

-(void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    // 自动改变透明度
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];//进入这个页面时自动下拉刷新
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
}


/**
 *  数据处理
 */
- (void)loadNewTopics{
    // 结束上拉
    [self.tableView.mj_footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        //字典转模型
        self.topics = [LYQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list" ]];
        //刷新表格
        [self.tableView reloadData];
        //结束下拉加载
        [self.tableView.mj_header endRefreshing];
        // 清空页码
        self.page = 0;
        //  将请求到的数据写到桌面
        //  [responseObject writeToFile:@"/Users/mac/Desktop/duanzi.plist" atomically:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //结束下拉加载
        [self.tableView.mj_header endRefreshing];
    }];
}

/**
 * 加载更多的帖子数据
 */
- (void)loadMoreTopics{
    // 结束下拉
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params
                               progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
                                   if (self.params != params) return;
                                   
                                   // 存储maxtime
                                   self.maxtime = responseObject[@"info"][@"maxtime"];
                                   
                                   // 字典 -> 模型
                                   NSArray *newTopics = [LYQTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
                                   [self.topics addObjectsFromArray:newTopics];
                                   
                                   // 刷新表格
                                   [self.tableView reloadData];
                                   
                                   // 结束刷新
                                   [self.tableView.mj_footer endRefreshing];
                               } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                   if (self.params != params) return;
                                   
                                   // 结束刷新
                                   [self.tableView.mj_footer endRefreshing];
                                   
                                   // 恢复页码
                                   self.page--;
                               }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);//没有数据时隐藏下拉刷新
    return self.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LYQTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:LYQTopicCellId];
    
    cell.topic = self.topics[indexPath.row];
    //    LYQTopic *topic = self.topics[indexPath.row];
    //    cell.textLabel.text = topic.name;
    //    cell.detailTextLabel.text = topic.text;
    //    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return cell;
}
#pragma mark-
#pragma mark- tableViewdatalite
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    // 取出帖子模型
    LYQTopic *topic = self.topics[indexPath.row];
    
//    // 文字的最大尺寸
//    CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * LYQTopicCellMargin, MAXFLOAT);
//    
//    CGFloat textH = [topic.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
//    
//    // cell的高度
//    CGFloat cellH = LYQTopicCellTextY + textH + LYQTopicCellBottomBarH + 2 * LYQTopicCellMargin;
    
    return topic.cellHeight;
}

#pragma mark -
#pragma mark - 懒加载
-(NSMutableArray *)topics{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    return _topics;
}
@end
