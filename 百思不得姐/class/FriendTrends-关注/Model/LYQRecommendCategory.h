//
//  LYQRecommendCategory.h
//  百思不得姐
//
//  Created by ma c on 16/5/29.
//  Copyright © 2016年 Lu. All rights reserved.
//
/**
 *  推荐关注左边的数据模型
 */
#import <Foundation/Foundation.h>

@interface LYQRecommendCategory : NSObject
/** id */
@property (nonatomic, assign) NSUInteger           id;
/** 总数 */
@property (nonatomic, assign) NSInteger           count;
/** 名字 */
@property (nonatomic, copy) NSString          * name;
/** 这个类别对应的用户数据 */
@property (nonatomic, strong) NSMutableArray            * users;

/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;

@end
