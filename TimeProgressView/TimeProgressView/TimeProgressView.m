//
//  TimeProgressView.m
//  MyTestDemos
//
//  Created by yy on 2017/5/2.
//  Copyright © 2017年 yy. All rights reserved.
//

#import "TimeProgressView.h"
#import "UIColor+hex.h"

@interface TimeProgressView ()<CAAnimationDelegate>

@property (nonatomic, strong) CAShapeLayer *progressShapeLayer;
@property (nonatomic, strong) CALayer *gradientLayer;

@property (nonatomic, strong) CABasicAnimation *progressAnimation;

@end

@implementation TimeProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    _gradientLayer = [CALayer layer];
    self.gradientLayer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"发言框"].CGImage);
    
    _progressShapeLayer = [CAShapeLayer new];
    self.progressShapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.progressShapeLayer.lineCap = kCALineCapRound;
    self.progressShapeLayer.strokeColor = [UIColor colorWithValue:0x00eaff].CGColor;
    self.progressShapeLayer.lineWidth = 2;
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gradientLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.layer.bounds), CGRectGetHeight(self.layer.bounds));
    self.progressShapeLayer.frame = self.layer.bounds;
}

- (void)startAnimationWithTime:(int64_t)time remindTime:(float)remindTime
{
    if (self.progressAnimation) {
        return;
    }
    
    [self.gradientLayer setMask:self.progressShapeLayer];
    [self.layer addSublayer:self.gradientLayer];
    
    CGFloat maxWidth = self.frame.size.width < self.frame.size.height ? self.frame.size.width : self.frame.size.height;
    CGPoint center = CGPointMake(maxWidth / 2.0, maxWidth / 2.0);
    CGFloat radius = maxWidth / 2.0;
    
    UIBezierPath *progressPath = [UIBezierPath bezierPathWithArcCenter:center
                                                                radius:radius - 2
                                                            startAngle:-M_PI_2
                                                              endAngle:3 * M_PI_2
                                                             clockwise:YES];
    progressPath.lineCapStyle = kCGLineCapRound;
    self.progressShapeLayer.path = progressPath.CGPath;
    
    _progressAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    self.progressAnimation.duration = time;
    self.progressAnimation.fromValue = @(0);
    self.progressAnimation.toValue = @(1);
    self.progressAnimation.delegate = self;
    self.progressAnimation.removedOnCompletion = NO;
    self.progressAnimation.fillMode = kCAFillModeForwards;
    [self.progressAnimation setValue:@"progressAnimation" forKey:@"key"];
    [self.progressShapeLayer addAnimation:self.progressAnimation forKey:@"progressAnimation"];

}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag;
{
    if (flag) {
        NSString *key = [anim valueForKey:@"key"];
        if ([key isEqualToString:@"progressAnimation"]) {
            [self endProgressAnimation];
        }
    }
}

- (void)endProgressAnimation
{
    self.progressAnimation.delegate = nil;
    self.progressAnimation = nil;
    
    [self.progressShapeLayer removeAnimationForKey:@"progressAnimation"];
    self.progressShapeLayer.path = nil;
}

@end
