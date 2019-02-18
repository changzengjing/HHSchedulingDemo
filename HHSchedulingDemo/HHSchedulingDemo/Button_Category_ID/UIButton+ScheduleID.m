//
//  UIButton+ScheduleID.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/14.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "UIButton+ScheduleID.h"
#import "objc/runtime.h"
static char scheduleIDKey;
@implementation UIButton (ScheduleID)

-(void)setScheduleID:(NSInteger)scheduleID
{
    objc_setAssociatedObject(self, &scheduleIDKey, @(scheduleID), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSInteger)scheduleID
{
    return [(NSNumber *)objc_getAssociatedObject(self, &scheduleIDKey) integerValue];
}

@end
