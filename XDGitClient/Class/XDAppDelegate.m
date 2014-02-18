//
//  XDAppDelegate.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-14.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDAppDelegate.h"

#import "XDViewController.h"
#import "XDLoginViewController.h"
#import "XDRootViewController.h"
#import "XDViewManager.h"
#import "XDRequestManager.h"
#import "XDConfigManager.h"

@implementation XDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[XDViewManager defaultManager] setupAppearance];
    
    [self loginStateChanged:nil];
    [self.window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginStateChanged:) name:KNOTIFICATION_LOFINSTATECHANGED object:nil];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - NSNotification

- (void)loginStateChanged:(NSNotification *)notification
{
    id<XDGitEngineProtocol> activityEngine = [[XDRequestManager defaultManager] activityGitEngine];
    [activityEngine didReset];
    [[XDConfigManager defaultManager] didReset];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *key = [NSString stringWithFormat:@"%@_%@_LoginName", APPNAME, activityEngine.engineKey];
    NSString *name = [defaults objectForKey:key];
    
    BOOL isLogin = YES;
    if (name == nil || name.length == 0) {
        isLogin = NO;
        
        XDLoginViewController *loginController = [[XDLoginViewController alloc] init];
        self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
    }
    else{
        XDRootViewController *rootController = [[XDRootViewController alloc] init];
        self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:rootController];
    }
    
    self.rootNavigationController.navigationBarHidden = isLogin;
    self.window.rootViewController = self.rootNavigationController;
}

@end
