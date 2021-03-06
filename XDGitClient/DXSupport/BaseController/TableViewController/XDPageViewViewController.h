//
//  XDPageViewViewController.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDTableViewController.h"

@interface XDPageViewViewController : XDTableViewController

@property (nonatomic) int page;//起始页为1
@property (nonatomic) BOOL haveNextPage;

- (void)fetchDataAtPage:(int)page isHeaderRefresh:(BOOL)isHeaderRefresh;

@end
