//
//  HHScheduleSelectionView.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/13.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "HHScheduleSelectionView.h"
#import "UILabel+CzyExtension.h"
#import "FSCalendarExtensions.h"
#import "HHAnimatePageControl.h"
#import "HHScheduleViewCell.h"

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
@interface HHScheduleSelectionView()<UICollectionViewDelegate,UICollectionViewDataSource,HHScheduleViewCellDelegate>
/// 关闭View按钮
@property (nonatomic,strong) UIButton *dismissBtn;
/// 将当期日期选中的排班重置 按钮
@property (nonatomic,strong) UIButton *resetBtn;
/// 背景View
@property (nonatomic,strong) UIView *backView;
/// 标题
@property (nonatomic,strong) UILabel *titleLabel;
/// 分界线
@property (nonatomic,strong) UIView *lineView;

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (nonatomic,strong) NSMutableArray *splitArr;

@property (nonatomic,strong) UIView *preSuperView;
@end

@implementation HHScheduleSelectionView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setView];
    }
    return self;
}
-(void)setView
{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
    [self addSubview:self.resetBtn];
    [self addSubview:self.dismissBtn];
    [self addSubview:self.lineView];
    
    [self setViewFrame];
    [self setCollectionViewUI];

}
-(void)setViewFrame
{
    CGFloat topMargin = 10;
    CGFloat btnWidth = 40;
    CGFloat btnHeight = 30;
    self.titleLabel.frame = CGRectMake(20, topMargin, kScreenWidth - 120 - topMargin, btnHeight);
    self.lineView.frame = CGRectMake(0, self.titleLabel.fs_bottom + topMargin, kScreenWidth, 1);
    self.dismissBtn.frame = CGRectMake(self.fs_width - topMargin - 45, topMargin, btnWidth, btnHeight);
    self.resetBtn.frame = CGRectMake(self.dismissBtn.fs_left - 20 - btnWidth, topMargin, btnWidth, btnHeight);
}
-(void)setCollectionViewUI
{
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc] init];
    
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    [flowLayout setMinimumLineSpacing:0.1];
//    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 0, 0, 0.1)];
    flowLayout.itemSize = CGSizeMake(self.fs_width, self.fs_height - self.lineView.fs_bottom - kTabbarSafeBottomMargin - 20);
    _flowLayout = flowLayout;
    _collectionView  = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.pagingEnabled = YES;
    
    [_collectionView registerClass:[HHScheduleViewCell class] forCellWithReuseIdentifier:@"HHScheduleViewCell"];
    _collectionView.backgroundColor =  [UIColor whiteColor];// [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1.0];
    [self addSubview:_collectionView];
    _collectionView.frame = CGRectMake(0, self.lineView.fs_bottom, kScreenWidth, self.fs_height - self.lineView.fs_bottom - kTabbarSafeBottomMargin - 20);
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _collectionView.fs_bottom, kScreenWidth, 20)];
    _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    
    _pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:1];
    [self addSubview:_pageControl];

    
}
#pragma mark - 加载数据
-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr = dataArr;
    [self.splitArr removeAllObjects];
    NSArray *arr = [self splitArray:dataArr withSubSize:7];
    self.splitArr = [NSMutableArray arrayWithArray:arr];
    _pageControl.numberOfPages = self.splitArr.count;
    if ([self isDescendantOfView:self.preSuperView]) {
        
    }
//    [self.collectionView reloadData];
}


/// 隐藏View
-(void)dismissScheduleView
{
    if (![self isDescendantOfView:self.preSuperView]) {
        return;
    }
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kScreenHeight - kNavHeight);
                         [self removeFromSuperview];
                     }
                     completion:nil];
}
/// 展示View
-(void)showToScheduleView:(UIView *)view
{
    self.preSuperView = view;
    if ([self isDescendantOfView:view]) {
        return;
    }
    [view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, kScreenHeight - (200 + kTabbarSafeBottomMargin), kScreenWidth, (200 + kTabbarSafeBottomMargin));
    } completion:^(BOOL finished) {
    }];
}
#pragma mark - 收起View
-(void)dissmiss
{
    [UIView animateWithDuration:0.18 animations:^{
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, (200 + kTabbarSafeBottomMargin));
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - 重置当前日期排班班名
-(void)resetBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(HHScheduleSelectionViewResetScheduleName)]) {
        [self.delegate HHScheduleSelectionViewResetScheduleName];
    }
}
#pragma mark - 配置HHScheduleViewCellDelegate
/// 跳过当前选中的日期
-(void)HHScheduleViewCellskipBtnClicked
{
    if ([self.delegate respondsToSelector:@selector(HHScheduleSelectionViewSkipDate)]) {
        [self.delegate HHScheduleSelectionViewSkipDate];
    }
}
/// 设置当前选中日期的班名
-(void)HHScheduleViewCellSetUpScheduleName:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(HHScheduleSelectionViewSetUpScheduleName:)]) {
        [self.delegate HHScheduleSelectionViewSetUpScheduleName:sender];
    }
}

#pragma mark - collectionViewDelegate && dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.splitArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHScheduleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HHScheduleViewCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.dataArr = self.splitArr[indexPath.row];
    return cell;
    
}
#pragma mark - 设置pageControl 的page
- (NSInteger)currentIndex
{
    if (_collectionView.frame.size.width == 0) return 0;
    
    return (_collectionView.contentOffset.x + _flowLayout.itemSize.width * 0.5) / _flowLayout.itemSize.width;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = [self currentIndex];
    _pageControl.currentPage = index % 5;
}
#pragma mark - lazyLayout
-(UIButton *)dismissBtn
{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _dismissBtn.titleLabel.textColor = [UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:1];
        [_dismissBtn setTitleColor:[UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:1] forState:UIControlStateNormal];
        [_dismissBtn setTitle:@"关闭" forState:UIControlStateNormal];
        _dismissBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        _dismissBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_dismissBtn addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dismissBtn;
}
-(UIButton *)resetBtn
{
    if (!_resetBtn) {
        _resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        _dismissBtn.titleLabel.textColor = [UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:1];
        [_resetBtn setTitleColor:[UIColor colorWithRed:116/255.0 green:187/255.0 blue:93/255.0 alpha:1] forState:UIControlStateNormal];
        [_resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        _resetBtn.titleLabel.font = [UIFont systemFontOfSize:14];
//        _resetBtn.translatesAutoresizingMaskIntoConstraints = NO;
        [_resetBtn addTarget:self action:@selector(resetBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}
-(UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}
-(UILabel *)titleLabel
{
    //[UIFont fontWithName:@"DINEngschriftStd" size:12];
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithFont:[UIFont boldSystemFontOfSize:16] textColor:[UIColor blackColor] textAlignment:NSTextAlignmentLeft];
        _titleLabel.text = @"点击下面班名设置排班";
    }
    return _titleLabel;
}
-(UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    }
    return _lineView;
}




- (NSArray *)splitArray: (NSArray *)array withSubSize : (int)subSize{
    //  数组将被拆分成指定长度数组的个数
    unsigned long count = array.count % subSize == 0 ? (array.count / subSize) : (array.count / subSize + 1);
    //  用来保存指定长度数组的可变数组对象
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    
    //利用总个数进行循环，将指定长度的元素加入数组
    for (int i = 0; i < count; i ++) {
        //数组下标
        int index = i * subSize;
        //保存拆分的固定长度的数组元素的可变数组
        NSMutableArray *arr1 = [[NSMutableArray alloc] init];
        //移除子数组的所有元素
        [arr1 removeAllObjects];
        
        int j = index;
        //将数组下标乘以1、2、3，得到拆分时数组的最大下标值，但最大不能超过数组的总大小
        while (j < subSize*(i + 1) && j < array.count) {
            [arr1 addObject:[array objectAtIndex:j]];
            j += 1;
        }
        //将子数组添加到保存子数组的数组中
        [arr addObject:[arr1 copy]];
    }
    
    return [arr copy];
}
-(NSMutableArray *)splitArr
{
    if (!_splitArr) {
        _splitArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _splitArr;
}
@end
