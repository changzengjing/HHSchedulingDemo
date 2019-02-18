//
//  HHScheduleColorHelper.m
//  HHSchedulingDemo
//
//  Created by 陈占勇 on 2018/9/12.
//  Copyright © 2018年 陈占勇. All rights reserved.
//

#import "HHScheduleColorHelper.h"
/** 颜色值 16进制 */
#define UIColorFromHex(s) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:1.0]
#define UIColorFromHexA(s,a) [UIColor colorWithRed:(((s & 0xFF0000) >> 16 )) / 255.0 green:((( s & 0xFF00 ) >> 8 )) / 255.0 blue:(( s & 0xFF )) / 255.0 alpha:(a/1.0)]

@interface HHScheduleColorHelper()
@property (nonatomic,strong) NSArray *dataArr;
@end
@implementation HHScheduleColorHelper
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}
+(NSArray*)scheduleColorArr:(NSInteger)count withType:(HHScheduleColorType)type
{
    //52b456   0x5f8340   0x415e45   7d7d7d    454477   465cb6   7e4fcf    6d4a83   73396d
    //b9c747    e7c252   c7a547   94672d   7c5452    a25b5a    54a998    5b9c9e   60ab5f
    NSArray *colorArr = [[NSArray alloc] init];
    colorArr  = @[
                  UIColorFromHex(0xb0a4e3),
                  UIColorFromHex(0xc83c23),
                  UIColorFromHex(0x9d2933),
                  
                  UIColorFromHex(0xcaa7cc),
                  UIColorFromHex(0xe2abe5),
                  
                  UIColorFromHex(0x4ae2c6),
                  UIColorFromHex(0xb35c44),
                  UIColorFromHex(0xff0097),
                  
                  UIColorFromHex(0xcca4e3),
                  UIColorFromHex(0xedd1d8),
                  UIColorFromHex(0xcca4e3),
                  UIColorFromHex(0xeacd76),

                  UIColorFromHex(0x801dae),
                  UIColorFromHex(0xc0ebd7),
                  
                  UIColorFromHex(0x16a951),
                  UIColorFromHex(0xfcefe8),
                  UIColorFromHex(0xffa400),
                  
                  UIColorFromHex(0xff461f),
                  UIColorFromHex(0x1685a9),
                  UIColorFromHex(0xa4e2c6),
                  
                  UIColorFromHex(0x52b456),
                  UIColorFromHex(0x5f8340),
                  UIColorFromHex(0x415e45),
                  
                  UIColorFromHex(0x7d7d7d),
                  UIColorFromHex(0x454477),
                  UIColorFromHex(0x465cb6),
                  
                  UIColorFromHex(0x7e4fcf),
                  UIColorFromHex(0x6d4a83),
                  UIColorFromHex(0x73396d),
                  
                  UIColorFromHex(0xb9c747),
                  UIColorFromHex(0xe7c252),
                  UIColorFromHex(0xc7a547),
                  
                  UIColorFromHex(0x94672d),
                  UIColorFromHex(0x7c5452),
                  UIColorFromHex(0xa25b5a),
                  
                  UIColorFromHex(0x54a998),
                  UIColorFromHex(0x5b9c9e),
                  UIColorFromHex(0x60ab5f),
                  
         //ed8448   e5996d   d8834d   df7572   e35c69   cb5d88   a65eb4   395c85   575252
                  
                  
                  
                  UIColorFromHex(0xed8448),
                  UIColorFromHex(0xe5996d),
                  UIColorFromHex(0xd8834d),
                  
                  UIColorFromHex(0xdf7572),
                  UIColorFromHex(0xe35c69),
                  UIColorFromHex(0xcb5d88),
                  
                  UIColorFromHex(0xa65eb4),
                  UIColorFromHex(0x395c85),
                  UIColorFromHex(0x575252),
                  
                  UIColorFromHex(0x9ed6d5),
                  UIColorFromHex(0x72c7c9),
                  UIColorFromHex(0xa6e5c8),
                  
                  UIColorFromHex(0x99c3e4),
                  UIColorFromHex(0x97a2df),
                  UIColorFromHex(0x7f7bd4),
                  
                  UIColorFromHex(0xebcebb),
                  UIColorFromHex(0xe3fea0),
                  UIColorFromHex(0xbcd194),
                  
                  UIColorFromHex(0xe6e695),
                  UIColorFromHex(0xc5d993),
                  UIColorFromHex(0x8bb292)

 

                  ];
    NSMutableArray *dataArr = [NSMutableArray arrayWithCapacity:0];
    [dataArr addObjectsFromArray:colorArr];
    if (type == HHScheduleColorTypeSome) {
        [dataArr subarrayWithRange:NSMakeRange(0, count -1)];
    }
    
    return dataArr;
}
@end
