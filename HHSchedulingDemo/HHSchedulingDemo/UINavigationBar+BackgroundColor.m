//
//  UINavigationBar+BackgroundColor.m
//  daizhe
//
//  Created by 苗晓东 on 15/5/19.
//  Copyright (c) 2015年 daizhe. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BackgroundColor)static char overlayKey;
static char overlayKey;

- (UIView *)overlay
{
    return objc_getAssociatedObject(self, &overlayKey);
}

- (void)setOverlay:(UIView *)overlay
{
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)dz_setBackgroundColor:(UIColor *)backgroundColor
{    if (!self.overlay) {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]];        // insert an overlay into the view hierarchy
    self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
    [self insertSubview:self.overlay atIndex:0];
}    self.overlay.backgroundColor = backgroundColor;
}

@end
