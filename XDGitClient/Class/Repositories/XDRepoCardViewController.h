//
//  XDRepoCardViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@class RepositoryModel;
@interface XDRepoCardViewController : XDTableViewController

- (id)initWithRepositoryModel:(RepositoryModel *)model;

@end
