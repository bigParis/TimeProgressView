//
//  ViewController.m
//  TimeProgressView
//
//  Created by yy on 2017/5/2.
//  Copyright © 2017年 BP. All rights reserved.
//

#import "ViewController.h"
#import "TimeProgressView.h"

@interface ViewController ()

@property (nonatomic, strong) TimeProgressView *timeProgressView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
}

- (void)initViews {
    TimeProgressView *timeProgressView = [[TimeProgressView alloc] init];
    [self.view addSubview:timeProgressView];
    self.timeProgressView = timeProgressView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //    self.timeProgressView.backgroundColor = [UIColor blackColor];
    self.timeProgressView.frame = CGRectMake(100, 100, 50, 50);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.timeProgressView startAnimationWithTime:60 remindTime:20];
}
@end
