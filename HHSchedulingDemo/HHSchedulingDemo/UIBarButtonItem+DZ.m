//
//  UIBarButtonItem+DZ.m
//  daizhe
//
//  Created by mxd on 14-9-19.
//  Copyright (c) 2014年 daizhe. All rights reserved.
//

#import "UIBarButtonItem+DZ.h"

@implementation UIBarButtonItem (DZ)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
//    btn.backgroundColor  =randomColor;
//    CGSize btnSize = btn.frame.size;
//    btnSize = CGSizeMake(btn.currentBackgroundImage.size.width, btn.currentBackgroundImage.size.height);
    btn.frame = CGRectMake(0, 0, 40, 30);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
@end