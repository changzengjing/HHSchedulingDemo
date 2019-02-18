//
//  HHScheduleViewCell.h
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/13.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HHScheduleViewCellDelegate<NSObject>

-(void)HHScheduleViewCellSetUpScheduleName:(UIButton *)sender;
-(void)HHScheduleViewCellskipBtnClicked;
@end

@interface HHScheduleViewCell : UICollectionViewCell
@property (nonatomic,weak) id<HHScheduleViewCellDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *dataArr;
@end
