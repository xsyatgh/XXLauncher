//
//  UMSLaunchVC.h
//  XXLauncher
//
//  Created by xsy on 16/8/31.
//  Copyright © 2016年 xsy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UMSLaunchVCDelegate <NSObject>

- (void)launchFinished;

@end

@interface UMSLaunchVC : UIViewController

@property (nonatomic, weak) id <UMSLaunchVCDelegate> delegate;

@end
