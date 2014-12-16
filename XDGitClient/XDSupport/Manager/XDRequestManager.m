//
//  XDRequestManager.m
//  leCar
//
//  Created by xieyajie on 13-12-30.
//  Copyright (c) 2013年 XDIOS. All rights reserved.
//

#import "XDRequestManager.h"

#import "XDGithubEngine.h"

static XDRequestManager *defaultManagerInstance = nil;

@implementation XDRequestManager

@synthesize githubEngine = _githubEngine;

- (id)init
{
    self = [super init];
    if (self) {
        _githubEngine = [XDGithubEngine shareEngine];
    }
    
    return self;
}

+ (XDRequestManager *)defaultManager
{
    @synchronized(self) {
        static dispatch_once_t pred;
        dispatch_once(&pred, ^{
            defaultManagerInstance = [[self alloc] init];
        });
    }
    return defaultManagerInstance;
}

@end
