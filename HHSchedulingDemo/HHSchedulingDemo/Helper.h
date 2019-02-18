//
//  Helper.h
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/14.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Helper : NSObject
+ (NSString *)validString:(NSString *)string;
/**
 *  判断数组是否为空
 */
+(BOOL)isBlankArray:(NSArray *)array;

/**
 *  判断字符串是否为空
 */
+ (BOOL)isBlankString:(NSString *)string;
+ (NSArray*)getDatesWithStartDate:(NSString *)startDate endDate:(NSString *)endDate;
@end
