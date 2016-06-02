//
//  LYQRecommendUserCell.m
//  百思不得姐
//
//  Created by ma c on 16/5/30.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQRecommendUserCell.h"
#import "LYQRecommendUser.h"
#import <UIImageView+WebCache.h>
@interface LYQRecommendUserCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;


@end

@implementation LYQRecommendUserCell


-(void)setUser:(LYQRecommendUser *)user{
    _user = user;
    self.screenNameLabel.text = user.screen_name;
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注",user.fans_count];
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
}


@end
