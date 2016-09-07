//
//  UMSSurroundView.m
//  XXLauncher
//
//  Created by xsy on 16/8/31.
//  Copyright © 2016年 xsy. All rights reserved.
//

#import "UMSSurroundView.h"
#import "UMSSurroundViewDelegate.h"

@interface UMSSurroundView ()

@property (nonatomic, strong) UMSSurroundAnimationConfig *config;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat percent;
@property (nonatomic, assign) BOOL isStopping;
@property (nonatomic, assign) BOOL isStarting;
@end

@implementation UMSSurroundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    if (0.001 < (width - height) || 0.001 < (height - width)) {
        NSLog(@"[ERROR] width must be equal height!");
    }
    
    _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:12.0];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.8];
    [self addSubview:_titleLabel];
    
    self.layer.cornerRadius = self.bounds.size.width/2.0;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor clearColor];
    _percent = 0;
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (void)startAnimationWithConfig:(UMSSurroundAnimationConfig *)config
{
    if (!config) {
        return;
    }
    if (_isStarting) {
        return;
    }
    _isStarting = true;
    _config = config;
    _titleLabel.frame = CGRectMake(config.bordWidth, config.bordWidth, self.bounds.size.width - 2*config.bordWidth, self.bounds.size.height - 2*config.bordWidth);
    _titleLabel.layer.cornerRadius = (self.bounds.size.width - 2*config.bordWidth)/2.0;
    _titleLabel.layer.masksToBounds = YES;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    _isStarting = false;
}

- (void)stopAnimation {
    if (_isStopping) {
        return;
    }
    _isStopping = true;
    [_displayLink invalidate];
    _displayLink = nil;
    _percent = 0;
    if (_delegate && [_delegate respondsToSelector:@selector(UMSSurroundViewAnimationFinished)] ) {
        [_delegate UMSSurroundViewAnimationFinished];
    }
    _isStopping = false;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, _config.bordWidth);
    CGContextSetStrokeColorWithColor(context, _config.bordColor.CGColor);
    //CGContextAddArc(上下文对象,  圆心x, 圆心y,  曲线开始点, 曲线结束点,  顺逆时针(1逆时针，0顺时针,apple的bug??))
    CGContextAddArc(context, self.frame.size.width/2.0,
                    self.frame.size.height/2.0,
                    self.bounds.size.width/2.0- _config.bordWidth/2.0,
                    _percent *(_config.endAngle - _config.startAngle) + _config.startAngle,
                    _config.endAngle ,
                    !_config.clockwise);
    CGContextStrokePath(context);
    [self graduallyChange];
}

- (void)graduallyChange
{
    NSInteger refreshFrequency = 60;
    _percent += 1/(_config.animationDuration*refreshFrequency);
    if (_percent > 1) {
        [self stopAnimation];
    }
}




@end
