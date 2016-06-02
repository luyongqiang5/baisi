//
//  LYQRecommendUser.h
//  百思不得姐
//
//  Created by ma c on 16/5/30.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LYQRecommendUser : NSObject
/** 头像 */
@property (nonatomic, copy) NSString          * header;
/** 粉丝数 */
@property (nonatomic, assign) NSInteger              fans_count;
/** 名字 */
@property (nonatomic, copy) NSString            * screen_name;
@end
