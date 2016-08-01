//
//  YDBar.m
//  Test
//
//  Created by renlei on 16/7/29.
//  Copyright © 2016年 YingDing. All rights reserved.
//

#import "YDBar.h"

static CGFloat kLabelH = 15;

static CGFloat kChartLineW = 20;

@interface YDBar ()

@property (nonatomic, strong) CATextLayer *textLayer;

@property (nonatomic, strong) CAShapeLayer *chartLine;

@end

@implementation YDBar

- (instancetype)initWithFrame:(CGRect)frame {
    frame.origin.y -= kLabelH;
    frame.size.height += kLabelH;
    if (self = [super initWithFrame:frame]) {
        [self setUpBar];
    }
    return self;
}

- (void)setUpBar {
    
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.frame.size.width / 2.0, self.frame.size.height)];
    [path addLineToPoint:CGPointMake(self.frame.size.width / 2.0, kLabelH)];
    
    _chartLine = [CAShapeLayer layer];
    _chartLine.fillColor  = [[UIColor whiteColor] CGColor];
    _chartLine.path = path.CGPath;
    _chartLine.lineWidth = kChartLineW;
    _chartLine.lineCap = kCALineCapButt;
    [self.layer addSublayer:_chartLine];
    
    _textLayer = [CATextLayer layer];
    _textLayer.fontSize = 10;
    _textLayer.alignmentMode = kCAAlignmentCenter;
    _textLayer.foregroundColor = [UIColor lightGrayColor].CGColor;
    _textLayer.contentsScale = [UIScreen mainScreen].scale;
    _textLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), kLabelH);
    [self.layer addSublayer:_textLayer];
    
    [self strokeChart];

}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.textLayer.string = title;
}


- (void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor = strokeColor;
    self.chartLine.strokeColor = strokeColor.CGColor;
}

- (void)strokeChart {

    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = @0.0f;
    pathAnimation.toValue = @1.0f;
    [self.chartLine addAnimation:pathAnimation forKey:nil];
    
    CABasicAnimation *textAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    textAnimation.duration = 1.0;
    textAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    textAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame)/2, self.frame.size.height-kLabelH/2)];
    textAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame)/2, kLabelH/2)];
    [self.textLayer addAnimation:textAnimation forKey:nil];
}

@end
