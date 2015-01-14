//
//  XDWebViewController.h
//  XDGitClient
//
//  Created by dhcdht on 15-1-5.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDViewController.h"

@interface XDWebViewController : XDViewController

- (instancetype)initWithUrlPath:(NSString *)urlPath;

- (instancetype)initWithHtmlString:(NSString *)htmlString;

- (void)loadHtmlString:(NSString *)htmlString;

- (void)loadPath:(NSString *)path;

- (void)closeWithDismiss;
- (void)closeWithPop;

@end
