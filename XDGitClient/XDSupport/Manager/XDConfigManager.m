//
//  XDConfigManager.m
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDConfigManager.h"

static XDConfigManager *defaultManagerInstance = nil;

@implementation XDConfigManager

- (id)init
{
    self = [super init];
    if (self) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _configDirectoryPath = [documentPath stringByAppendingPathComponent:@"config"];
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:_configDirectoryPath]) {
            [fm createDirectoryAtPath:_configDirectoryPath withIntermediateDirectories:YES attributes:Nil error:nil];
        }
    }
    return self;
}

+ (XDConfigManager *)defaultManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultManagerInstance = [[XDConfigManager alloc] init];
        });
    }
    
    return defaultManagerInstance;
}

- (void)loadConfigFilePath
{
    _configFilePath = [_configDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_%@_config", APPNAME, @"github"]];
}

@end
