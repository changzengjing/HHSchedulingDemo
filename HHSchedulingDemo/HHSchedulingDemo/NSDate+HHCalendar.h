//
//  NSDate+HHCalendar.h
//  BeautyChange
//
//  Created by 陈占勇 on 2018/1/3.
//  Copyright © 2018年 arsmo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (HHCalendar)
@property (nonatomic, strong) NSCalendar *cld;
///每月第一天的星期
- (NSInteger)firstDay_week;
///每月最后一天的星期
- (NSInteger)lastDay_week;
///当前日期的星期
- (NSInteger)getWeek;
///增加月
- (NSDate *)addMonth:(NSInteger)month;
///增加年
- (NSDate *)addYear:(NSInteger)year;
///增加日
- (NSDate *)addDay:(NSInteger)day;
///当月天数
- (NSInteger)dayOfMonth;
///当前日期年份
- (NSInteger)getYear;
///当前日期月份
- (NSInteger)getMonth;

//当前日期日
- (NSInteger)getDay;
///是否相等 精确到日
- (BOOL)isSameTo:(NSDate *)date;
///更换为今天
- (NSDate *)changToDay:(NSInteger)day;
///是否早于当前日期 精确到日
- (BOOL)earlyThan:(NSDate *)date;
///星期转文字
- (NSString *)weekString;
@end
