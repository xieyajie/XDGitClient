//
//  XDAccountCardViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@interface XDAccountCardViewController : XDTableViewController

- (id)initWithAccount:(AccountModel *)model;

- (void)dismissButtonTapped:(id)sender;

@end
