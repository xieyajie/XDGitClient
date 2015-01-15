//
//  XDFileListViewController.h
//  XDGitClient
//
//  Created by dhcdht on 15-1-15.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@interface XDFileListViewController : XDTableViewController

- (instancetype)initWithRepositoryFullName:(NSString *)repoFullName filePath:(NSString *)filePath;

@end
