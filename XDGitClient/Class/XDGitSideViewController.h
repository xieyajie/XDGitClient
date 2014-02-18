//
//  XDGitSideViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-14.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@class XDGitDeckViewController;
@interface XDGitSideViewController : XDTableViewController

@property (strong, nonatomic) XDGitDeckViewController *deckController;
@property (strong, nonatomic) UINavigationController *projectNavTabController;
@property (strong, nonatomic) UINavigationController *activityNavController;

@end
