//
//  DXTabBarController.h
//  DXStudio
//
//  Created by yajie xie on 12-9-5.
//  Copyright (c) 2012年 DXStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DXTabBarItem.h"

@interface DXTabBarController : UIViewController
{
    UIView *_slideBg;
}

@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, assign, readonly) BOOL tabBarHidden;;
@property (nonatomic, strong)  NSArray *viewControllers;
@property (nonatomic, strong)  UIViewController *activityController;

- (void)tabBarHidden:(BOOL)hidden;
- (void)tabBarHidden:(BOOL)hidden animated:(BOOL)animated;

@end
