//
//  XDViewManager.m
//  XDHoHo
//
//  Created by xieyajie on 13-12-2.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import "XDViewManager.h"

#import "XDAppDelegate.h"

static XDViewManager *defaultManagerInstance = nil;

@implementation XDViewManager

- (id)init
{
    self = [super init];
    if (self) {
        _appDelegate = (XDAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

+ (XDViewManager *)defaultManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultManagerInstance = [[self alloc] init];
        });
    }
    
    return defaultManagerInstance;
}

- (UINavigationController *)appRootNavController
{
    return _appDelegate.rootNavigationController;
}

- (void)setupAppearance
{
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(version >= 5.0)
    {
        //导航栏
        NSString *nameSuffix = (version >= 7.0) ? @"_i7" : @"";
        NSString *imageName = [NSString stringWithFormat:@"navi_bg_prompt%@", nameSuffix];
        UIImage *tempImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        [[UINavigationBar appearance] setBackgroundImage:tempImage forBarMetrics:UIBarMetricsDefaultPrompt];
        
        imageName = [NSString stringWithFormat:@"navi_bg%@", nameSuffix];
        tempImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        [[UINavigationBar appearance] setBackgroundImage:tempImage forBarMetrics:UIBarMetricsDefault];
        
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
        [attributesDictionary setValue:[UIFont boldSystemFontOfSize:20.0]               forKey:NSFontAttributeName];
        [attributesDictionary setValue:[UIColor whiteColor]                             forKey:NSForegroundColorAttributeName];
        [[UINavigationBar appearance] setTitleTextAttributes:attributesDictionary];
    }
}

- (void)showLoadingViewWithTitle:(NSString *)title requestOperation:(AFHTTPRequestOperation *)requestOperation
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_loadingView == nil) {
            _loadingView = [[XDLoadingView alloc] initWithRequestOperation:requestOperation title:title];
        }
        else{
            _loadingView.title = title;
            _loadingView.requestOperation = requestOperation;
        }
        
        [[UIApplication sharedApplication].keyWindow addSubview:_loadingView];
        [_loadingView start];
    });
}

- (void)hideLoadingView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_loadingView stop];
        [_loadingView removeFromSuperview];
    });
}

//- (void)showGuideView
//{
//    //欢迎页
//    NSString *appVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];;
//    if (![[[NSUserDefaults standardUserDefaults] valueForKey:@"Version_Intro"] isEqualToString:appVersion]) {
//        [[NSUserDefaults standardUserDefaults] setValue:appVersion forKey:@"Version_Intro"];
//        self.guideVC = [[XDGuideViewController alloc] init];
//        [[UIApplication sharedApplication].keyWindow addSubview:self.guideVC.view];
//    }
//}

@end
