//
//  HHSchedulingCell.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/11.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "HHSchedulingCell.h"
#import "FSCalendarExtensions.h"
#import "Helper.h"
#import "HHScheduleColorHelper.h"
@implementation HHSchedulingCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 农历
        self.tipLabel = [[YYLabel alloc] init];
        self.tipLabel.font = [UIFont systemFontOfSize:8.8];
        [self.contentView addSubview:self.tipLabel];
        self.tipLabel.textAlignment = NSTextAlignmentLeft;
        self.tipLabel.textColor = [UIColor lightGrayColor];
        self.tipLabel.verticalForm = YES;
        // 排班
        self.scheduleLabel = [[UILabel alloc] init];
        self.scheduleLabel.font = [UIFont fontWithName:@"DINEngschriftStd" size:12];
        self.scheduleLabel.adjustsFontSizeToFitWidth = YES;
//        self.scheduleLabel.font = [UIFont systemFontOfSize:11];
//        self.scheduleLabel.text = @"排班";
        self.scheduleLabel.textAlignment = NSTextAlignmentCenter;

        self.scheduleLabel.textColor = [UIColor whiteColor];
        self.scheduleLabel.layer.cornerRadius = 4;
        self.scheduleLabel.layer.masksToBounds = YES;
        [self.contentView addSubview:self.scheduleLabel];
        
    }
    return self;
}

-(void)setTipLabel:(NSString *)tipStr withScheduleLabel:(NSDictionary *)scheduleDict
{
    if (![Helper isBlankString:scheduleDict[@"name"]]) {
        
        self.scheduleLabel.backgroundColor = [UIColor colorWithRed:117/255.0 green:170/255.0 blue:132/255.0 alpha:1];
        NSArray *colorArr = [HHScheduleColorHelper scheduleColorArr:0 withType:HHScheduleColorTypeAll];
        NSString *idStr =  scheduleDict[@"id"];
        NSInteger idValue = [idStr integerValue];
        self.scheduleLabel.backgroundColor = colorArr[idValue];
        self.scheduleLabel.text = scheduleDict[@"name"];
    }else
    {
        self.scheduleLabel.backgroundColor = [UIColor clearColor];
        self.scheduleLabel.text = @"";
    }
    
    self.tipLabel.text = tipStr;
}
-(void)setSchedulingLabelStr:(NSDictionary *)scheduleDict
{
    if (![Helper isBlankString:scheduleDict[@"name"]]) {
        
        self.scheduleLabel.backgroundColor = [UIColor colorWithRed:117/255.0 green:170/255.0 blue:132/255.0 alpha:1];
        NSArray *colorArr = [HHScheduleColorHelper scheduleColorArr:0 withType:HHScheduleColorTypeAll];
        NSString *idStr =  scheduleDict[@"id"];
        NSInteger idValue = [idStr integerValue];
        self.scheduleLabel.backgroundColor = colorArr[idValue];
        self.scheduleLabel.text = scheduleDict[@"name"];
    }else
    {
        self.scheduleLabel.backgroundColor = [UIColor clearColor];
        self.scheduleLabel.text = @"";
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(self.titleLabel.fs_left, self.titleLabel.fs_top + 1, self.titleLabel.fs_width, self.titleLabel.fs_height);
    self.tipLabel.frame = CGRectMake(self.contentView.fs_width/2, 5, self.contentView.fs_width/2, self.contentView.fs_height);
    self.scheduleLabel.frame = CGRectMake(5, self.contentView.fs_height/2 + 2, self.contentView.fs_width - 10, self.contentView.fs_height/2 - 2 - 4);
}
- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
    //    self.shapeLayer.frame = self.contentView.bounds;
}
@end
