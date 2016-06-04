//
//  LYQTextField.m
//  百思不得姐
//
//  Created by ma c on 16/6/4.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQTextField.h"
#import <objc/runtime.h>
static NSString * const LYQPlacerholderColorKeyPath = @"_placeholderLabel.textColor";
@implementation LYQTextField

+ (void)initialize
{
//    [self getIvars];
}

+ (void)getProperties
{
    unsigned int count = 0;
    
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出属性
        objc_property_t property = properties[i];
        
        // 打印属性名字
        LYQLog(@"%s   <---->   %s", property_getName(property), property_getAttributes(property));
    }
    
    free(properties);
}

+ (void)getIvars
{
    unsigned int count = 0;
    
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        //        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        
        // 打印成员变量名字
        LYQLog(@"%s %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    
    // 释放
    free(ivars);
}

/*（1）awakeFromNib和initWithCoder:差别
 awakeFromNib 从xib或者storyboard加载完毕就会调用
 initWithCoder: 只要对象是从文件解析来的，就会调用
 同时存在会先调用initWithCoder:
 
 （2）initWithCoder: & initWithFrame:
 initWithCoder：使用文件加载的对象调用（如从xib或stroyboard中创建）
 initWithFrame：使用代码加载的对象调用（使用纯代码创建）
 注意：所以为了同时兼顾从文件和从代码解析的对象初始化，要同时在initWithCoder: 和 initWithFrame: 中进行初始化
 
 */
- (void)awakeFromNib
{
    // 设置光标颜色和文字颜色一致
    self.tintColor = self.textColor;
    
    // 不成为第一响应者
    [self resignFirstResponder];
}

/**
 * 当前文本框聚焦时就会调用
 */
-(BOOL)becomeFirstResponder{
    
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:LYQPlacerholderColorKeyPath];
    return [super becomeFirstResponder];
}
/**
 * 当前文本框失去聚焦时就会调用
 */
-(BOOL)resignFirstResponder{
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:LYQPlacerholderColorKeyPath];
    return [super resignFirstResponder];
}
@end
