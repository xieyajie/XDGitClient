//
//  XDAccountViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@interface XDAccountViewController : XDTableViewController

@property (strong, nonatomic) NSString *userName;

- (id)initWithUsername:(NSString *)userName;

- (void)requestDataWithRefresh:(BOOL)isRefresh;

@end
