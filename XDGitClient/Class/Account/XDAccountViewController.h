//
//  XDAccountViewController.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-21.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDPageViewViewController.h"

@interface XDAccountViewController : XDPageViewViewController

@property (strong, nonatomic) NSString *userName;

- (id)initWithUsername:(NSString *)userName;

@end
