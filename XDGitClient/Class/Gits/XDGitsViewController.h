//
//  XDGitsViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPageViewViewController.h"

@interface XDGitsViewController : XDPageViewViewController

- (id)initWithGitsStyle:(XDGitStyle)style;

- (id)initWithUserName:(NSString *)userName gitsStyle:(XDGitStyle)style;

@end
