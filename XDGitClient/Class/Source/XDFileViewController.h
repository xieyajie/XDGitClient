//
//  XDFileViewController.h
//  XDGitClient
//
//  Created by dhcdht on 15-1-15.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDWebViewController.h"

@class RepoSourceModel;
@interface XDFileViewController : XDWebViewController

- (instancetype)initWithSourceModel:(RepoSourceModel *)model;

@end
