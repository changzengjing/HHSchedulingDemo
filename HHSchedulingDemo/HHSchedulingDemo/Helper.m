//
//  Helper.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/14.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "Helper.h"

@implementation Helper
/** 返回不为nil的string */
+ (NSString *)validString:(NSString *)string {
    
    if ([self isBlankString:string]) {
        return  @"";
    } else {
        return string;
    }
}
/**
 *  判断字符串是否为空| 为空返回Yes  不为空返回NO
 */
+ (BOOL)isBlankString:(NSString *)string {
    
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSDictionary class]]) {
        return YES;
    }
    if ([string isKindOfClass:[NSString class]] == NO) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}
/**
 *  判断数组是否为空
 */
+(BOOL)isBlankArray:(NSArray *)array
{
    if (array == nil || array == NULL) {
        return YES;
    }
    if ([array isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (array.count == 0) {
        return YES;
    }
    return NO;
}
+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    
    //字符串转时间
    NSDateFormatter *matter = [[NSDateFormatter alloc] init];
    matter.dateFormat = @"yyyy-MM-dd";
    NSDate *start = [matter dateFromString:startDate];
    NSDate *end = [matter dateFromString:endDate];
    
    NSMutableArray *componentAarray = [NSMutableArray array];
    NSComparisonResult result = [start compare:end];
    NSDateComponents *comps;
    while (result != NSOrderedDescending) {
        comps = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |  NSCalendarUnitWeekday fromDate:start];
        [componentAarray addObject:start];
        
        //后一天
        [comps setDay:([comps day]+1)];
        start = [calendar dateFromComponents:comps];
        
        //对比日期大小
        result = [start compare:end];
    }
    return componentAarray;
}
@end
