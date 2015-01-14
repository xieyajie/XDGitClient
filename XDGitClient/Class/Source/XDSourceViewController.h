//
//  XDSourceViewController.h
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@class RepositoryModel;
@interface XDSourceViewController : XDTableViewController

- (instancetype)initWithRepository:(RepositoryModel *)model;

@end
