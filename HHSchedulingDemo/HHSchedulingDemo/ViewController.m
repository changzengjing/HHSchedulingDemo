//
//  ViewController.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/10.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+HHCalendar.h"
#import "HHSchedulingCell.h"
#import "LunarFormatter.h"
#import "UIButton+ScheduleID.h"
#import "HHScheduleSelectionView.h"
#import "HHScheduleFromDateHelper.h"
#import "HHScheduleColorHelper.h"
#import "Helper.h"
#define NTBlue [UIColor colorWithRed:0.15f green:0.67f blue:1.00f alpha:1.00f]
#define kNavHeight (IS_IPhoneX ? 88.0 : 64.0)
#define IS_IPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
/***  当前屏幕宽度 */
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/***  当前屏幕高度 */
#define kScreenHeight  [[UIScreen mainScreen] bounds].size.height
/// 安全区域
#define  kTabbarSafeBottomMargin        (IS_IPhoneX ? 34.f : 0.f)
@interface ViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance,HHScheduleSelectionViewDelegate>
@property (weak, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDateFormatter *dateFormatter1;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) LunarFormatter *lunarFormatter;
@property (nonatomic,strong) HHScheduleSelectionView *scheduleView;

@property (nonatomic,strong) NSMutableArray *scheduleArr;


@property (nonatomic,strong) NSArray *scheduleNameArr;
@property (nonatomic,strong) NSDate *selectedDate;
@end

@implementation ViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _lunarFormatter = [[LunarFormatter alloc] init];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = @[
                     @{@"date":@"2018-09-04",@"id":@"0",@"name":@"白班"},
                     @{@"date":@"2018-09-12",@"id":@"1",@"name":@"夜班"},
                     @{@"date":@"2018-09-18",@"id":@"2",@"name":@"上半休"},
                     @{@"date":@"2018-09-20",@"id":@"3",@"name":@"下半休"},
                     @{@"date":@"2018-09-21",@"id":@"4",@"name":@"午班"},
                     @{@"date":@"2018-09-22",@"id":@"4",@"name":@"午班"},
                     @{@"date":@"2018-09-24",@"id":@"5",@"name":@"休息"},
                     @{@"date":@"2018-09-30",@"id":@"6",@"name":@"出差"}
                     ];
    
    self.scheduleNameArr = @[
                             @{@"name":@"白班",@"id":@"0"},
                             @{@"name":@"夜班",@"id":@"1"},
                             @{@"name":@"上半休",@"id":@"2"},
                             @{@"name":@"下半休",@"id":@"3"},
                             @{@"name":@"午班",@"id":@"4"},
                             @{@"name":@"休息",@"id":@"5"},
                             @{@"name":@"吃饭",@"id":@"7"},
                             @{@"name":@"小夜",@"id":@"8"},
                             @{@"name":@"公司活动",@"id":@"9"},
                             @{@"name":@"大夜",@"id":@"10"},
                             @{@"name":@"出差",@"id":@"6"}
                             ];
    self.selectedDate = [NSDate date];
    NSDate *maxDate = [self getMaxDate];
    NSInteger year = [maxDate getYear];
    NSInteger month = [maxDate getMonth];
    //    NSInteger day = [maxDate getDay];
    self.dateFormatter1 = [[NSDateFormatter alloc] init];
    self.dateFormatter1.dateFormat = @"yyyy-MM-dd";
    NSString *minDateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02d",(long)year,(long)month,1];
    NSDate *minSelectedDate = [self.dateFormatter1 dateFromString:minDateStr];
    [self.calendar selectDate:minSelectedDate];
    self.scheduleArr = [NSMutableArray arrayWithArray:arr];
    self.title = @"陈占勇's排班";
    [self setRightBarButton];
    
}

-(void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : (self.view.bounds.size.width /7.0 * 6.0);
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, kNavHeight, self.view.bounds.size.width, height + 60)];
    calendar.dataSource = self;
    calendar.delegate = self;
    //    calendar.rowHeight = ;
    calendar.allowsMultipleSelection = NO;
    calendar.swipeToChooseGesture.enabled = NO;
    
    NSLog(@"%f  ---   %f",calendar.headerHeight ,calendar.weekdayHeight);
    
    calendar.appearance.titleFont = [UIFont systemFontOfSize:19];
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.weekdayHeight = 30;
    calendar.headerHeight = 30;
    calendar.appearance.headerTitleColor = [UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:1];
    calendar.appearance.weekdayTextColor = [UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:1];
    
    calendar.appearance.titleDefaultColor = [UIColor blackColor];
    calendar.appearance.titleSelectionColor = [UIColor blackColor];
    calendar.appearance.titleFont = [UIFont fontWithName:@"DINEngschriftStd" size:20];
    calendar.appearance.weekdayFont = [UIFont fontWithName:@"DINEngschriftStd" size:16];
    calendar.appearance.subtitleFont = [UIFont fontWithName:@"DINEngschriftStd" size:13];
    calendar.appearance.titleOffset = CGPointMake(0, 0);
    calendar.appearance.subtitleOffset = CGPointMake(0, 3);
    calendar.appearance.selectionColor = [UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:0.3];
    calendar.appearance.todayColor = [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1];
    calendar.appearance.titleTodayColor = [UIColor blackColor];
    calendar.appearance.titleSelectionColor = [UIColor blackColor];
    calendar.appearance.subtitleDefaultColor = [UIColor whiteColor];
    calendar.appearance.subtitlePlaceholderColor = [UIColor whiteColor];
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase|FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
    calendar.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    [calendar setCurrentPage:[NSDate date] animated:NO];
    [calendar registerClass:[HHSchedulingCell class] forCellReuseIdentifier:@"cell"];
}
#pragma mark - 创建导航栏右边按钮
-(void)setRightBarButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更换" style:UIBarButtonItemStylePlain target:self action:@selector(fangXiangBtnClick)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"今天" style:UIBarButtonItemStylePlain target:self action:@selector(backTodayClick)];
}
#pragma mark - 更换日历切换方向
-(void)fangXiangBtnClick
{
    if (self.calendar.scrollDirection == FSCalendarScrollDirectionVertical) {
        self.calendar.scrollDirection = FSCalendarScrollDirectionHorizontal;
    }else
    {
        self.calendar.scrollDirection = FSCalendarScrollDirectionVertical;
    }
}
#pragma mark - 回到今天
-(void)backTodayClick{
    [self.calendar setCurrentPage:[NSDate date] animated:YES];
}
#pragma mark - 日历的delegate && dataSource
// 正选
-(void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
    self.selectedDate = date;
    NSLog(@"%@",[self.dateFormatter stringFromDate:self.selectedDate]);
    [self.scheduleView showToScheduleView:self.view];
    
    self.scheduleView.dataArr = self.scheduleNameArr;
}



// 反选
- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
}

-(BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSDate *maxDate = [self getMaxDate];
    NSInteger year = [maxDate getYear];
    NSInteger month = [maxDate getMonth];
    NSInteger day = [maxDate getDay];
    NSString *minDateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02d",(long)year,(long)month,1];
    NSString *maxDateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",(long)year,(long)month,(long)day];
    
    NSArray *dateArr = [Helper getDatesWithStartDate:minDateStr endDate:maxDateStr];
    NSLog(@"%@",dateArr);
    
    BOOL shouldSelect = [dateArr containsObject:date];
    if (!shouldSelect) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"排班提示" message:[NSString stringWithFormat:@"排班日期 %@  已不能被选择，只可选择%ld月排班",[self.dateFormatter stringFromDate:date],month] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"明白" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        [self.scheduleView dismissScheduleView];
    } else {
        NSLog(@"Should select date %@",[self.dateFormatter1 stringFromDate:date]);
    }
    return shouldSelect;
}

// 设置日历中所呈现的最小日期
-(NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    NSDate *currentDate =  [NSDate date];
    return [currentDate addMonth:-2];
}

-(NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    NSDate *date = [self getMaxDate];
    return date;
}
// 无事件
- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date
{
    return 0;
}

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    //    if ([self.gregorian isDateInToday:date]) {
    //        return @"今";
    //    }
    return nil;
}


- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    return @"";
}

-(FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)position
{
    HHSchedulingCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:position];
    NSString *tipStr = [self.lunarFormatter stringFromDate:date];
    HHScheduleFromDateHelper *scheduleHelper = [[HHScheduleFromDateHelper alloc] init];
    NSDictionary *dict = [scheduleHelper stringFromDate:date withDataArr:self.scheduleArr];
    [cell setTipLabel:tipStr withScheduleLabel:dict];
    
    return cell;
}

-(void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"%@",calendar.currentPage);
    
    NSDate *maxDate = [self getMaxDate];
    NSInteger year = [maxDate getYear];
    NSInteger month = [maxDate getMonth];
    NSInteger day = [maxDate getDay];
    NSString *minDateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02d",(long)year,(long)month,1];
    NSString *maxDateStr = [NSString stringWithFormat:@"%02ld-%02ld-%02ld",(long)year,(long)month,(long)day];
    
    NSArray *dateArr = [Helper getDatesWithStartDate:minDateStr endDate:maxDateStr];
    
    //    NSInteger currentPageMonth = [calendar.currentPage getMonth];
    //    NSInteger currentPageYear = [calendar.currentPage getYear];
    NSDate *currentPageDate = calendar.currentPage;
    // 包含
    if ([dateArr containsObject:currentPageDate]) {
        [self.scheduleView showToScheduleView:self.view];
        self.scheduleView.dataArr = self.scheduleNameArr;
    }else
    {
        [self.scheduleView dismissScheduleView];
    }
    
}

// 设置形状 圆形还是方形
- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{
    return 0.0;
}

//设置日历中日期的文字颜色
-(UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleDefaultColorForDate:(NSDate *)date
{
    NSString *string = [self calculateWeek:date];
    if ([string isEqualToString:@"周六"] ||[string isEqualToString:@"周日"] ) {
        return [UIColor lightGrayColor];
    }else
    {
        return nil;
    }
}
- (NSString *)calculateWeek:(NSDate *)date{
    //计算week数
    NSCalendar * myCalendar = [NSCalendar currentCalendar];
    myCalendar.timeZone = [NSTimeZone systemTimeZone];
    NSInteger week = [[myCalendar components:NSWeekdayCalendarUnit fromDate:date] weekday];
    //    NSLog(@"week : %zd",week);
    switch (week) {
        case 1:
        {
            return @"周日";
        }
        case 2:
        {
            return @"周一";
        }
        case 3:
        {
            return @"周二";
        }
        case 4:
        {
            return @"周三";
        }
        case 5:
        {
            return @"周四";
        }
        case 6:
        {
            return @"周五";
        }
        case 7:
        {
            return @"周六";
        }
    }
    return @"";
}

/// 获取最大日期的date
-(NSDate *)getMaxDate{
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy-MM";
    NSDate *maxDate = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentDate options:0];
    
    NSString *preDate = [formate stringFromDate:maxDate];
    //获取天数
    NSInteger days = [maxDate dayOfMonth];
    NSString *afterDays = [NSString stringWithFormat:@"-%02ld",(long)days];
    NSString *maxDateStr = [NSString stringWithFormat:@"%@%@",preDate,afterDays];
    NSDate *date = [self.dateFormatter dateFromString:maxDateStr];
    return date;
}
/// 跳过某个日期
-(void)jumpToNextDate
{
    NSDate *date = self.selectedDate;
    NSLog(@"%@",[self.dateFormatter stringFromDate:date]);
    NSDate *nextDate = [date addDay:1];
    NSLog(@"%@",[self.dateFormatter stringFromDate:nextDate]);
    NSDate *maxDate = [self getMaxDate];
    if ([date earlyThan:maxDate]) {
        [self.calendar selectDate:nextDate];
        self.selectedDate = nextDate;
    }
    
}

-(HHScheduleSelectionView *)scheduleView
{
    if (!_scheduleView) {
        _scheduleView = [[HHScheduleSelectionView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 200 + kTabbarSafeBottomMargin)];
        _scheduleView.delegate = self;
        
    }
    return _scheduleView;
}


#pragma mark - HHScheduleSelectionViewDelegate
/// 设置当前选中日期班名
-(void)HHScheduleSelectionViewSetUpScheduleName:(UIButton *)sender
{
    NSString *btnStr = sender.currentTitle;
    NSInteger idValue = sender.scheduleID;
    NSString  * idStr = [NSString stringWithFormat:@"%ld",(long)idValue];
    NSString *selectedDateStr = [self.dateFormatter stringFromDate:self.selectedDate];
    NSInteger i = 0;
    NSMutableArray *dateArr = [NSMutableArray arrayWithArray:self.scheduleArr];
    for (NSDictionary *dict in self.scheduleArr) {
        NSString *dateName = dict[@"date"];
        if ([selectedDateStr isEqualToString:dateName]) {
            [dateArr removeObjectAtIndex:i];
            [dateArr addObject:@{@"date":dateName,@"id":idStr,@"name":btnStr}];
            break;
        }else{
            if (i == self.scheduleArr.count - 1) {
                [dateArr addObject:@{@"date":selectedDateStr,@"id":idStr,@"name":btnStr}];
            }
        }
        i ++;
    }
    [self.scheduleArr removeAllObjects];
    self.scheduleArr = [NSMutableArray arrayWithArray:dateArr];
    [dateArr removeAllObjects];
    [self.calendar reloadData];
    [self jumpToNextDate];
}
/// 跳过当前选中日期

-(void)HHScheduleSelectionViewSkipDate
{
    [self jumpToNextDate];
}
/// 重置当前选中日期的班名 - 清空
-(void)HHScheduleSelectionViewResetScheduleName
{
    NSString *selectedDateStr = [self.dateFormatter stringFromDate:self.selectedDate];
    NSInteger i = 0;
    NSMutableArray *dateArr = [NSMutableArray arrayWithArray:self.scheduleArr];
    for (NSDictionary *dict in self.scheduleArr) {
        NSString *dateName = dict[@"date"];
        if ([selectedDateStr isEqualToString:dateName]) {
            [dateArr removeObjectAtIndex:i];
            break;
        }
        i ++;
    }
    self.scheduleArr = [NSMutableArray arrayWithArray:dateArr];
    [self.calendar reloadData];
    
    
}
@end
