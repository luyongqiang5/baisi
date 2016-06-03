//
//  LYQRecommendTagsViewController.m
//  百思不得姐
//
//  Created by ma c on 16/6/3.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQRecommendTagsViewController.h"
#import "LYQRecommendTagCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "LYQRecommendTag.h"
@interface LYQRecommendTagsViewController ()
/** 标签数据 */
@property (nonatomic, strong) NSArray *tags;
@end

static NSString * const LYQTagsId = @"tag";

@implementation LYQRecommendTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadTags];
}

-(void)loadTags{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    // 请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    //发送请求
    [[AFHTTPSessionManager manager]GET:@"http://api.budejie.com/api/api_open.php" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.tags = [LYQRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"加载标签数据失败!"];
        
    }];
}

-(void)setupTableView{
    self.view.backgroundColor = LYQGlobalBg;
    self.title = @"推荐关注";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([LYQRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:LYQTagsId];
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    LYQRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:LYQTagsId];
    
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}


@end
