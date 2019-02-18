//
//  UILabel+CzyExtension.m
//  BeautyChange
//
//  Created by 陈占勇 on 2017/11/17.
//  Copyright © 2017年 arsmo. All rights reserved.
//

#import "UILabel+CzyExtension.h"

@implementation UILabel (CzyExtension)

- (instancetype)initWithFont:(UIFont *)font
                   textColor:(UIColor *)textColor
               textAlignment:(NSTextAlignment)textAlignment {
    if (self = [super init]) {
        self.font = font;
        self.textAlignment = textAlignment ? textAlignment : NSTextAlignmentLeft;
        self.textColor = textColor;
    }
    return self;
}

+ (instancetype)labelWithFont:(UIFont *)font
                    textColor:(UIColor *)textColor
                textAlignment:(NSTextAlignment)textAlignment {
    return [[UILabel alloc] initWithFont:font textColor:textColor textAlignment:textAlignment];
}

- (void)alignTop
{
    CGSize fontSize = [self.text sizeWithFont:self.font];
    
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    
    
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    
    
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    
    for(int i=0; i<= newLinesToPad; i++)
    {
        self.text = [self.text stringByAppendingString:@" \n"];
    }
}

- (void)alignBottom
{
    CGSize fontSize = [self.text sizeWithFont:self.font];
    
    double finalHeight = fontSize.height * self.numberOfLines;
    double finalWidth = self.frame.size.width;    //expected width of label
    
    
    CGSize theStringSize = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    
    
    int newLinesToPad = (finalHeight  - theStringSize.height) / fontSize.height;
    
    for(int i=0; i< newLinesToPad; i++)
    {
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}

@end
