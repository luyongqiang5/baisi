//
//  LYQRecommendCategoryCell.m
//  百思不得姐
//
//  Created by ma c on 16/5/29.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQRecommendCategoryCell.h"
#import "LYQRecommendCategory.h"

@interface LYQRecommendCategoryCell ()
/**
 *  选中时显示的条
 */
@property (weak, nonatomic) IBOutlet UIView *selectedIndictor;

@end

@implementation LYQRecommendCategoryCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = LYQRGBColor(244,244 , 244);
    /**
     *  左侧线的颜色
     */
    self.selectedIndictor.backgroundColor = LYQRGBColor(219, 21, 26);
    // 当cell的selection为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
}

-(void)setCategory:(LYQRecommendCategory *)category{
    _category = category;
    self.textLabel.text = category.name;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //重新调整内部textlabel的高度
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
/**
 * 可以在这个方法中监听cell的选中和取消选中
 */
-(void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
    self.selectedIndictor.hidden = !selected ;
//    self.textLabel.textColor = selected ? (LYQRGBColor(219, 21, 26)) : (LYQRGBColor(78, 78, 78));
    if (selected) {
        self.textLabel.textColor = self.selectedIndictor.backgroundColor;
    }else{
        self.textLabel.textColor = LYQRGBColor(78, 78, 78);
    }
    
}

@end
