//
//  LYQRecommendTag.h
//  百思不得姐
//
//  Created by ma c on 16/6/3.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYQRecommendTag : NSObject
/** 图片 */
@property (nonatomic, copy) NSString *image_list;
/** 名字 */
@property (nonatomic, copy) NSString *theme_name;
/** 订阅数 */
@property (nonatomic, assign) NSInteger sub_number;
@end
