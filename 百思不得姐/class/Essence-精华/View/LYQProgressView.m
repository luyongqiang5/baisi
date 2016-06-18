//
//  LYQProgressView.m
//  百思不得姐
//
//  Created by ma c on 16/6/18.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQProgressView.h"

@implementation LYQProgressView

- (void)awakeFromNib
{
    self.roundedCorners = 2;
    self.progressLabel.textColor = LYQRGBColor(244, 244, 244);
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    //将字符串中的“-”换为“”
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
