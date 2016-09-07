//
//  UMSLaunchVC.m
//  XXLauncher
//
//  Created by xsy on 16/8/31.
//  Copyright © 2016年 xsy. All rights reserved.
//

#import "UMSLaunchVC.h"
#import "UMSSurroundView.h"
#import "UMSSurroundViewDelegate.h"

@interface UMSLaunchVC ()<UMSSurroundViewDelegate>
@property (nonatomic, strong) UMSSurroundView *surroundView;
@property (nonatomic, assign) CGFloat surroundViewHeight;
@end

@implementation UMSLaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _surroundViewHeight = 35.0;
    [self addSurroundView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _surroundView.frame = CGRectMake(self.view.frame.size.width - 2*_surroundViewHeight, _surroundViewHeight, _surroundViewHeight, _surroundViewHeight);
}


- (void)addSurroundView
{
    _surroundView = [[UMSSurroundView alloc] initWithFrame:CGRectMake(0, 0, _surroundViewHeight, _surroundViewHeight)];
    _surroundView.title = @"pass";
    [self.view addSubview:_surroundView];
    [self animation];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pass)];
    [_surroundView addGestureRecognizer:tap];
}

- (void)animation
{
    UMSSurroundAnimationConfig *config = [[UMSSurroundAnimationConfig alloc] init];
    config.bordWidth = 2.0;
    config.bordColor = [UIColor redColor];
    config.animationDuration = 3.0;
    config.startAngle = 1.5*M_PI;
    config.endAngle = 2*M_PI+1.5*M_PI;
    config.clockwise = YES;
    [_surroundView startAnimationWithConfig:config];
    _surroundView.delegate = self;
}

- (void)pass {
    [_surroundView stopAnimation];
}

#pragma mark - UMSSurroundViewDelegate

- (void)UMSSurroundViewAnimationFinished
{
    if (_delegate && [_delegate respondsToSelector:@selector(launchFinished)]) {
        [_delegate launchFinished];
    }
}


@end
