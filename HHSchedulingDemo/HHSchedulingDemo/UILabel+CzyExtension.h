//
//  UILabel+CzyExtension.h
//  BeautyChange
//
//  Created by 陈占勇 on 2017/11/17.
//  Copyright © 2017年 arsmo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (CzyExtension)
- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment;
+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment;
- (void)alignTop;
- (void)alignBottom;
@end
