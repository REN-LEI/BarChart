//
//  ViewController.m
//  BarChartDome
//
//  Created by renlei on 16/8/1.
//  Copyright © 2016年 YingDing. All rights reserved.
//

#import "ViewController.h"
#import "YDBarChart.h"

@interface ViewController ()

@property (nonatomic,strong) YDBarChart *barChart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    YDBarChart *barChart = [[YDBarChart alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-50, self.view.frame.size.width, self.view.frame.size.height/2+50)];
    
    barChart.xLabels = @[@"语文",@"数学",@"英语",@"语文2",@"数学2",@"英语2",@"英语3"];
    
    barChart.yLabels = @[@"0%",@"10%",@"20%",@"30%",@"40%",@"50%",
                         @"60%",@"70%",@"80%",@"90%",@"100%"];
    
    barChart.yValues = @[@70,@80,@96,@72.6,@80,@100,@15.5];
    
    barChart.strokeColors = @[[UIColor orangeColor],
                              [UIColor magentaColor],
                              [UIColor brownColor],
                              [UIColor redColor],
                              [UIColor cyanColor],
                              [UIColor purpleColor],
                              [UIColor blackColor]];
    
    barChart.formatter = ^NSString *(NSNumber *value) {
        return [NSString stringWithFormat:@"%.2f%%",value.floatValue];
    };
    [self.view addSubview:barChart];
    
    self.barChart = barChart;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.barChart strokeChart];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
