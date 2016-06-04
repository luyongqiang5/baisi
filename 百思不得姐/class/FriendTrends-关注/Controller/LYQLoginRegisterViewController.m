//
//  LYQLoginRegisterViewController.m
//  百思不得姐
//
//  Created by ma c on 16/6/3.
//  Copyright © 2016年 Lu. All rights reserved.
//

#import "LYQLoginRegisterViewController.h"

@interface LYQLoginRegisterViewController ()
/** 登录框距离控制器view左边的间距 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@end

@implementation LYQLoginRegisterViewController

//退出登录界面
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showLoginOrRegister:(id)sender {
    // 退出键盘
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // 显示注册界面
        self.loginViewLeftMargin.constant = - self.view.width;
//        button.selected = YES;
        [sender setTitle:@"已有账号？"forState:UIControlStateNormal];
    } else { // 显示登录界面
        self.loginViewLeftMargin.constant = 0;
//        button.selected = NO;
        [sender setTitle:@"注册账号"forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    // 文字属性
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    // NSAttributedString : 带有属性的文字(富文本技术)
//    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:attrs];
//    self.phoneField.attributedPlaceholder = placeholder;
    /**(富文本技术)
     *  @param attrs 放一个字典
     *  @param range NSMakeRange(0, 1)从下标为0的字开始数1位，改变字的属性（颜色、大小等）
     *  - (void)setAttributes:(nullable NSDictionary<NSString *, id> *)attrs range:(NSRange)range;
     */
    
//        NSMutableAttributedString *placehoder = [[NSMutableAttributedString alloc] initWithString:@"手机号"];
//        [placehoder setAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} range:NSMakeRange(0, 1)];
//        [placehoder setAttributes:@{
//                                    NSForegroundColorAttributeName : [UIColor yellowColor],
//                                    NSFontAttributeName : [UIFont systemFontOfSize:30]
//                                    } range:NSMakeRange(1, 1)];
//        [placehoder setAttributes:@{NSForegroundColorAttributeName : [UIColor redColor]} range:NSMakeRange(2, 1)];
//        self.phoneField.attributedPlaceholder = placehoder;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 让当前控制器对应的状态栏是白色
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
