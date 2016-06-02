//
//  LYQRecommendCategory.m
//  百思不得姐
//
//  Created by ma c on 16/5/29.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQRecommendCategory.h"

@implementation LYQRecommendCategory
-(NSMutableArray *)users{
    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}
@end
