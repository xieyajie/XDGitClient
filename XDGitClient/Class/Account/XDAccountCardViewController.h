//
//  XDAccountCardViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPageViewViewController.h"

@interface XDAccountCardViewController : XDPageViewViewController

- (id)initWithAccount:(AccountModel *)model;

- (void)dismissButtonTapped:(id)sender;

@end
