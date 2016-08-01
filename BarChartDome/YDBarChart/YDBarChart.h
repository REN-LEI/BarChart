//
//  YDBarChart.h
//  Test
//
//  Created by renlei on 16/7/29.
//  Copyright © 2016年 YingDing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSString *(^YDLabelFormatter)(NSNumber *yLabelValue);


@interface YDBarChart : UIView

/// x轴上文字显示
@property (nonatomic, strong) NSArray <NSString *>*xLabels;

/// y轴上文字显示 
@property (nonatomic, strong) NSArray <NSString *>*yLabels;

/// y轴上数值
@property (nonatomic, strong) NSArray <NSNumber *>*yValues;

/// 对应每个柱状图的颜色
@property (nonatomic, strong) NSArray *strokeColors;

/// 显示规则
@property (nonatomic, copy) YDLabelFormatter formatter;

/// 以动画的方式绘制图表
- (void)strokeChart;


@end
