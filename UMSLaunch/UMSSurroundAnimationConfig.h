//
//  UMSSurroundAnimationConfig.h
//  XXLauncher
//
//  Created by xsy on 16/8/31.
//  Copyright © 2016年 xsy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UMSSurroundAnimationConfig : NSObject
// bord
@property (nonatomic, assign) CGFloat bordWidth;
// bord color
@property (nonatomic, strong) UIColor *bordColor;
// animation duration
@property (nonatomic, assign) CGFloat animationDuration;
// start angle using M_PI * ??
@property (nonatomic, assign) CGFloat startAngle;
// end angle using M_PI * ??
@property (nonatomic, assign) CGFloat endAngle;
// YES clockwise, NO otherwise
@property (nonatomic, assign) BOOL clockwise;

@end
