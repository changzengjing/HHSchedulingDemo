//
//  NTNavigationViewController.m
//  nursetime
//
//  Created by inspiry on 15/10/21.
//  Copyright © 2015年 inspiry. All rights reserved.
//

#import "NTNavigationController.h"
#import "UIBarButtonItem+DZ.h"
//app用的最多的蓝色
#define NTBlue [UIColor colorWithRed:0.15f green:0.67f blue:1.00f alpha:1.00f]
@interface NTNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NTNavigationController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}
+ (void)initialize
{
 //    设置导航栏主题
    [self setupNavigation];
 //    设置导航栏按钮主题
    [self setupNavigationBarBtn];
}
/**
 *  设置导航栏主题
 */
+ (void)setupNavigation
{
    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar dz_setBackgroundColor:NTBlue];
    navBar.barTintColor = NTBlue;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor whiteColor];
//    navBar.tintColor = [UIColor whiteColor];
    //    dict[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    [navBar setTitleTextAttributes:dict];
}
+ (void)setupNavigationBarBtn
{
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    NSMutableDictionary *textDicts = [NSMutableDictionary dictionary];
    textDicts[NSForegroundColorAttributeName] = [UIColor whiteColor];
    //    textDicts[UITextAttributeTextShadowOffset] = [NSValue valueWithUIOffset:UIOffsetZero];
    textDicts[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    [barItem setTitleTextAttributes:textDicts forState:UIControlStateNormal];
}
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"arrow_left" highImage:@"arrow_left" target:self action:@selector(back)];
    }
    [super pushViewController:viewController animated:animated];
    
}
/**
 *  返回上个控制器
 */
- (void)back
{
    [self popViewControllerAnimated:YES];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
@end

