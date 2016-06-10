//
//  NSDate+LYQExtension.h
//  百思不得姐
//
//  Created by ma c on 16/6/10.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LYQExtension)
/**
 * 比较from和self的时间差值
 */
- (NSDateComponents *)deltaFrom:(NSDate *)from;
/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;
@end
