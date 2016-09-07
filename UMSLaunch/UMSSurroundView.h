//
//  UMSSurroundView.h
//  XXLauncher
//
//  Created by xsy on 16/8/31.
//  Copyright © 2016年 xsy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSSurroundAnimationConfig.h"

@protocol UMSSurroundViewDelegate;

@interface UMSSurroundView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, weak) id<UMSSurroundViewDelegate> delegate;

- (void)startAnimationWithConfig:(UMSSurroundAnimationConfig *)config;

- (void)stopAnimation;

@end
