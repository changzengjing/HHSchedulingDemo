//
//  HHScheduleFromDateHelper.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/14.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "HHScheduleFromDateHelper.h"
@interface HHScheduleFromDateHelper()
@property (strong, nonatomic) NSDateFormatter *formatter;
@end
@implementation HHScheduleFromDateHelper
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.formatter = [[NSDateFormatter alloc] init];
        self.formatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}
-(NSDictionary *)stringFromDate:(NSDate *)date withDataArr:(NSArray *)dateArr
{
    NSString *dateName = @"";
    NSDictionary *dict = @{};
    for (NSDictionary * dateDic in dateArr) {
        NSString *dateStr = [self.formatter stringFromDate:date];
        NSLog(@"%@ || %@",dateStr,dateDic[@"date"]);
        
        if ([dateStr isEqualToString:dateDic[@"date"]]) {
            NSLog(@"%@",dateDic[@"name"]);
            dateName = dateDic[@"name"];
            dict = [NSDictionary dictionaryWithDictionary:dateDic];
            break;
        }
        
    }
    return dict;
}
@end
