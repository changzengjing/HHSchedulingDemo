//
//  HHScheduleColorHelper.h
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/12.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM (NSInteger, HHScheduleColorType)   {
    
    HHScheduleColorTypeAll = 0,
    HHScheduleColorTypeSome = 1
    
};
@interface HHScheduleColorHelper : NSObject
+(NSArray *)scheduleColorArr:(NSInteger)count withType:(HHScheduleColorType)type;
@end
