//
//  LYQTopicViewController.h
//  百思不得姐
//
//  Created by ma c on 16/6/12.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    LYQTopicTypeAll = 1,
    LYQTopicTypePicture = 10,
    LYQTopicTypeWord = 29,
    LYQTopicTypeVoice = 31,
    LYQTopicTypeVideo = 41
}LYQTopicType;

@interface LYQTopicViewController : UITableViewController
/** 帖子的类型 */
@property (nonatomic, assign) LYQTopicType          type;
@end
