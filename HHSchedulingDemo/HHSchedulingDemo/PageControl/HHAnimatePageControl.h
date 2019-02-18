//
//  HHAnimatePageControl.h
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/13.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, PageStyle){
    HHScaleColorPageStyle,
    HHSquirmPageStyle,
    HHDepthColorPageStyle,
    HHFillColorPageStyle,
};
@interface HHAnimatePageControl : UIControl
@property (nonatomic, strong) UIScrollView *sourceScrollView;
@property (nonatomic, assign) NSInteger numberOfPages;
@property (nonatomic, strong) UIColor *pageIndicatorColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;
@property (nonatomic, assign) CGFloat indicatorMultiple;
@property (nonatomic, assign) CGFloat indicatorMargin;
@property (nonatomic, assign) CGFloat indicatorDiameter;
@property (nonatomic, assign) PageStyle pageStyle;
@property (nonatomic, assign, readonly) NSInteger currentPage;

- (void)prepareShow;
- (void)clearIndicators;
@end
