//
//  HHScheduleSelectionView.h
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/13.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HHScheduleSelectionViewDelegate<NSObject>
/// 设置当前选中日期班名
-(void)HHScheduleSelectionViewSetUpScheduleName:(UIButton *)sender;
/// 重置当前选中日期的班名 - 清空
-(void)HHScheduleSelectionViewResetScheduleName;
/// 跳过当前选中日期
-(void)HHScheduleSelectionViewSkipDate;
@end

@interface HHScheduleSelectionView : UIView

@property (nonatomic,strong) NSArray *dataArr;
/// 展示View
-(void)showToScheduleView:(UIView *)view;
/// 隐藏View
-(void)dismissScheduleView;
/// 构造方法
@property (nonatomic,weak) id<HHScheduleSelectionViewDelegate> delegate;
@end
