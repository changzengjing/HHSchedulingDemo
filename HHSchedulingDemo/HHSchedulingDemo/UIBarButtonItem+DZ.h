//
//  UIBarButtonItem+DZ.h
//  daizhe
//
//  Created by mxd on 14-9-19.
//  Copyright (c) 2014年 daizhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DZ)
/**
 *  导航栏左右按钮分类方法
 */
+ (instancetype) itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;
@end
