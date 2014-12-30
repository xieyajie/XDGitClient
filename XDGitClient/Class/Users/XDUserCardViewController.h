//
//  XDUserCardViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPageViewViewController.h"

@interface XDUserCardViewController : XDPageViewViewController

- (id)initWithUser:(UserModel *)model;

- (void)dismissButtonTapped:(id)sender;

@end
