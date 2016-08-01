//
//  YDBarChart.m
//  Test
//
//  Created by renlei on 16/7/29.
//  Copyright © 2016年 YingDing. All rights reserved.
//

#import "YDBarChart.h"
#import "YDBar.h"

/// 左边label的宽
static CGFloat leftW = 40;
/// 底部label的高
static CGFloat bottomH = 35;
/// 顶部预留高度
static CGFloat topH = 15;
/// 离右边的间距
static CGFloat rightSpacing = 10;

@interface YDBarChart ()

@property (nonatomic, strong) CAShapeLayer *chartBottomLine;

@property (nonatomic, strong) CAShapeLayer *chartLeftLine;

@end

@implementation YDBarChart

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpBarChart];
    }
    return self;
}

- (void)setUpBarChart {
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.formatter = ^NSString *(NSNumber *value) {
        return [NSString stringWithFormat:@"%@",value];
    };
    
    /// 线条颜色
    UIColor *lineColor = [UIColor colorWithRed:225.0 / 255.0 green:225.0 / 255.0 blue:225.0 / 255.0 alpha:1.0f];
    
    UIBezierPath *bottomPath = [UIBezierPath bezierPathWithRect:CGRectMake(leftW, CGRectGetHeight(self.frame)-bottomH, CGRectGetWidth(self.frame)-rightSpacing-leftW, 1)];
    _chartBottomLine = [CAShapeLayer layer];
    _chartBottomLine.path = bottomPath.CGPath;
    _chartBottomLine.lineCap = kCALineCapButt;
    _chartBottomLine.fillColor = [lineColor CGColor];
    _chartBottomLine.lineWidth = 1.0;
    [self.layer addSublayer:_chartBottomLine];
    
    
    UIBezierPath *leftPath = [UIBezierPath bezierPathWithRect:CGRectMake(leftW, topH, 1, CGRectGetHeight(self.frame)-topH-bottomH)];
    _chartLeftLine = [CAShapeLayer layer];
    _chartLeftLine.path = leftPath.CGPath;
    _chartLeftLine.lineCap = kCALineCapButt;
    _chartLeftLine.fillColor = [lineColor CGColor];
    _chartLeftLine.lineWidth = 1.0;
    [self.layer addSublayer:_chartLeftLine];
    
}

- (void)strokeChart {
    
    [self.xLabels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(leftW + (CGRectGetWidth(self.frame)-leftW-rightSpacing)/_xLabels.count*idx, CGRectGetHeight(self.frame)-bottomH, (CGRectGetWidth(self.frame)-leftW)/_xLabels.count, bottomH);
        label.text = obj;
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:11];
        [self addSubview:label];
    }];
    
    [self.yLabels enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.text = [NSString stringWithFormat:@"%@",obj];;
        label.font = [UIFont systemFontOfSize:11];
        [label sizeToFit];
        
        CGFloat kXLabelHeight = label.frame.size.height;
        float sectionHeight = (self.frame.size.height - bottomH - topH - kXLabelHeight ) / (_yLabels.count-1);
        label.frame = CGRectMake(0, self.frame.size.height-bottomH-(topH + sectionHeight * idx) , leftW-5, kXLabelHeight);
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
    }];
    
    
    [self.yValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    
        CGFloat w = (CGRectGetWidth(self.frame) - rightSpacing - leftW )/_yValues.count;
        
        CGFloat h = (CGRectGetHeight(self.frame)-bottomH-topH)*(obj.floatValue/100);
        
        CGFloat y = (CGRectGetHeight(self.frame)-h-bottomH);
        
        YDBar *bar = [[YDBar alloc] initWithFrame:CGRectMake(leftW + w*idx, y, w , h)];
        bar.strokeColor = [self barColorAtIndex:idx];
        bar.title =  self.formatter(obj);
        [self addSubview:bar];
    }];
}

- (UIColor *)barColorAtIndex:(NSUInteger)index
{
    if ([self.strokeColors count] >= [self.yValues count]) {
        return self.strokeColors[index];
    }
    else {
        if (self.strokeColors.count > index) {
            return self.strokeColors[index];
        }
        return self.strokeColors.count != 0 ?[self.strokeColors lastObject]:[UIColor lightGrayColor];
    }
}

@end
