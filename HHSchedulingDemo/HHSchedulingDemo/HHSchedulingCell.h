//
//  HHSchedulingCell.h
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/11.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "FSCalendarCell.h"
#import "YYLabel.h"
@interface HHSchedulingCell : FSCalendarCell
@property (nonatomic,strong) YYLabel *tipLabel;

@property (nonatomic,strong) UILabel *scheduleLabel;


-(void)setTipLabel:(NSString *)tipStr withScheduleLabel:(NSDictionary *)scheduleDict;
-(void)setSchedulingLabelStr:(NSDictionary *)scheduleDict;
@end
