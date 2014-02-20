//
//  XDRepositoryViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@interface XDRepositoryViewController : XDTableViewController

- (id)initWithProjectsStyle:(XDRepositoryStyle)style;

- (id)initWithUserName:(NSString *)userName repositoryStyle:(XDRepositoryStyle)style;

@end
