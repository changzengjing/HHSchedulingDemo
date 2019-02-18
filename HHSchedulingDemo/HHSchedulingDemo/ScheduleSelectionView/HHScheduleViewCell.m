//
//  HHScheduleViewCell.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/13.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "HHScheduleViewCell.h"
#import "UIButton+ScheduleID.h"
#import "HHScheduleColorHelper.h"
/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
#define kNavHeight (IS_IPhoneX ? 88.0 : 64.0)
#define IS_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/// 安全区域
#define  kTabbarSafeBottomMargin        (IS_IPhoneX ? 34.f : 0.f)
/// 状态栏高度
#define  kStatusBarHeight      (IS_IPhoneX ? 44.f : 20.f)
/** 颜色值 16进制 */
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:1.0]
#define UIColorFromHexA(s,a) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:(a/1.0)]
@interface HHScheduleViewCell()

@end
@implementation HHScheduleViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

-(void)setUpViews
{
//    int R = (arc4random() % 256) ;
//    int G = (arc4random() % 256) ;
//    int B = (arc4random() % 256) ;
//    self.contentView.backgroundColor = [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
}

-(void)setDataArr:(NSMutableArray *)dataArr
{
    _dataArr = dataArr;
    
    int totalloc =4;
    CGFloat margin =10; //间距
    CGFloat btnVW = (kScreenWidth-margin*5)/4; //宽
    CGFloat btnVH = 45; //高
    NSInteger count = dataArr.count + 1;
    for (NSInteger i=0;i<count;i++){
        NSInteger row =i/totalloc;  //行号
        NSInteger loc =i%totalloc;  //列号
        CGFloat btnVX =margin+(margin +btnVW)*loc; //x
        CGFloat btnVY =15 + (margin +btnVH)*row; //y
        
        
        if (i == 0) {
            UIButton *skipBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            skipBtn.frame = CGRectMake(btnVX, btnVY, btnVW, btnVH);
            [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
            [skipBtn setTitleColor:[UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1] forState:UIControlStateNormal];
            [skipBtn setBackgroundColor:[UIColor whiteColor]];
            skipBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
            skipBtn.layer.borderColor = [UIColor colorWithRed:117/255.0 green:117/255.0 blue:117/255.0 alpha:1].CGColor;
            [skipBtn addTarget:self action:@selector(skipBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            skipBtn.layer.borderWidth = 1.8;
            [self.contentView addSubview:skipBtn];
        }else
        {
            NSString *btnStr = dataArr[i - 1][@"name"];
            NSString *idStr = dataArr[i - 1][@"id"];
            NSArray *colorArr = [HHScheduleColorHelper scheduleColorArr:0 withType:HHScheduleColorTypeAll];
            NSInteger idValue =  [idStr integerValue];
            UIColor *colorStr = colorArr[idValue];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(btnVX, btnVY, btnVW, btnVH);
            btn.scheduleID = idValue;
            [btn setTitle:btnStr forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:colorStr];
            btn.titleLabel.font = [UIFont systemFontOfSize:17];
            btn.titleLabel.adjustsFontSizeToFitWidth = YES;
            btn.tag=i+1000;
            [btn  addTarget:self action:@selector(setUpScheduleName:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview: btn];
        }
        
    }
}


#pragma mark - 设置班名
-(void)setUpScheduleName:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(HHScheduleViewCellSetUpScheduleName:)]) {
        [self.delegate HHScheduleViewCellSetUpScheduleName:sender];
    }
}
#pragma mark - 跳过
-(void)skipBtnClicked:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(HHScheduleViewCellskipBtnClicked)]) {
        [self.delegate HHScheduleViewCellskipBtnClicked];
    }
}
@end
