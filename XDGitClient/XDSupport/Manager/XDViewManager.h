//
//  XDViewManager.h
//  XDHoHo
//
//  Created by xieyajie on 13-12-2.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XDLoadingView.h"

@class XDAppDelegate;
@interface XDViewManager : NSObject
{
    XDAppDelegate *_appDelegate;
    XDLoadingView *_loadingView;
}

+ (XDViewManager *)defaultManager;

- (void)setupAppearance;

- (void)showLoadingViewWithTitle:(NSString *)title requestOperation:(AFHTTPRequestOperation *)requestOperation;
- (void)hideLoadingView;

//- (void)showGuideView;// 引导页面

//- (void)scanImagesWithURLs:(NSArray *)imagesURL;  //多图浏览

@end
