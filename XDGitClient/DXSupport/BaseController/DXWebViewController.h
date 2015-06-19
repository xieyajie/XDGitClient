//
//  DXWebViewController.h
//  DXStudio
//
//  Created by dhcdht on 15-1-5.
//  Copyright (c) 2015年 DXStudio. All rights reserved.
//

#import "DXViewController.h"

@interface DXWebViewController : DXViewController

- (instancetype)initWithUrlPath:(NSString *)urlPath;

- (instancetype)initWithHtmlString:(NSString *)htmlString;

- (void)loadHtmlString:(NSString *)htmlString;

- (void)loadPath:(NSString *)path;

- (void)closeWithDismiss;
- (void)closeWithPop;

@end
