//
//  XDViewManager.h
//  XDHoHo
//
//  Created by xieyajie on 13-12-2.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XDAppDelegate;
@interface XDViewManager : NSObject
{
    XDAppDelegate *_appDelegate;
}

+ (XDViewManager *)defaultManager;

- (void)setupAppearance;

//- (void)showGuideView;// 引导页面

//- (void)scanImagesWithURLs:(NSArray *)imagesURL;  //多图浏览

@end
