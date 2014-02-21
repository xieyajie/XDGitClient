//
//  XDFollowViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDAccountViewController.h"

@interface XDFollowViewController : XDAccountViewController

- (id)initWithFollowers:(BOOL)isFollowers;

- (id)initWithUserName:(NSString *)userName isFollowers:(BOOL)isFollowers;

@end
