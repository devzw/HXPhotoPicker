//
//  HXFullScreenCameraPlayView.m
//  照片选择器
//
//  Created by 洪欣 on 2017/5/23.
//  Copyright © 2017年 洪欣. All rights reserved.
//

#import "HXFullScreenCameraPlayView.h"

@interface HXFullScreenCameraPlayView ()
// 进度扇形
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (assign, nonatomic) CGFloat currentProgress;
@property (assign, nonatomic) CGPoint progressCenter;
@end

@implementation HXFullScreenCameraPlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame color:(UIColor *)color {
    if (self = [super initWithFrame:frame]) {
        self.color = color;
        [self setup];
    }
    return self;
}

- (void)setColor:(UIColor *)color {
    if (!color) {
        color = [UIColor colorWithRed:253/255.0 green:142/255.0 blue:36/255.0 alpha:1];
    }
    _color = color;
    self.progressLayer.strokeColor = color.CGColor;
}

- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    self.progressCenter = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CAShapeLayer *progressLayer = [CAShapeLayer layer];
    progressLayer.strokeColor = self.color.CGColor;
    progressLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0].CGColor;
    progressLayer.lineWidth = 5;
    progressLayer.path = [UIBezierPath bezierPathWithArcCenter:self.progressCenter radius:self.frame.size.width * 0.5 - 2.5 startAngle:-M_PI / 2 endAngle:-M_PI / 2 + M_PI * 2 * 1 clockwise:true].CGPath;
    progressLayer.hidden = YES;
    [self.layer addSublayer:progressLayer];
    self.progressLayer = progressLayer;
    self.currentProgress = 0.f;
}
- (void)clean {
    self.progressLayer.hidden = YES;
    self.currentProgress = 0;
}
- (void)setProgress:(CGFloat)progress {
    _progress = progress; 
    self.progressLayer.hidden = NO;
    [self.progressLayer removeAnimationForKey:@"circle"];
    CABasicAnimation *circleAnim = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnim.fromValue = @(self.currentProgress);
    circleAnim.toValue = @(progress);
    circleAnim.duration = 0.2f;
    circleAnim.fillMode = kCAFillModeForwards;
    circleAnim.removedOnCompletion = NO;
    circleAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    [self.progressLayer addAnimation:circleAnim forKey:@"circle"];
    
//    self.progressLayer.path = [UIBezierPath bezierPathWithArcCenter:self.progressCenter radius:self.progressCenter.x startAngle:-M_PI / 2.f endAngle:-M_PI / 2.f + M_PI * 2.f * progress clockwise:true].CGPath;
    
    self.currentProgress = progress;
}
- (UIBezierPath *)pathForProgress:(CGFloat)progress {
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGFloat radius = self.frame.size.height * 0.5;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:-M_PI / 2 endAngle:-M_PI / 2 + M_PI * 2 * progress clockwise:true];
    path.lineWidth = 3;
    return path;
}

@end
