//
//  AppConfigModel.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-11.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "AppConfigModel.h"

@implementation AppConfigModel

@synthesize loginUsername = _loginUsername;
@synthesize loginToken = _loginToken;

@synthesize repositorySortName = _repositorySortName;
@synthesize repositorySortType = _repositorySortType;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        NSString *rsname = [dictionary objectForKey:KCONFIG_SORT_REPOSITORY_NAME];
        if ([rsname length] == 0) {
            rsname = @"updated";
        }
        self.repositorySortName = rsname;
        
        NSString *rstype = [dictionary objectForKey:KCONFIG_SORT_REPOSITORY_TYPE];
        if ([rstype length] == 0) {
            rstype = @"desc";
        }
        self.repositorySortType = rstype;
        
        NSString *loginUsername = [dictionary objectForKey:KCONFIG_LOGIN_USERNAME];
        if ([loginUsername length] > 0) {
            self.loginUsername = loginUsername;
        }
        
        NSString *loginToken = [dictionary objectForKey:KCONFIG_LOGIN_TOKEN];
        if ([loginToken length] > 0) {
            self.loginToken = loginToken;
        }
    }
    
    return self;
}

- (NSDictionary *)dictionaryForValues
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    if (self.repositorySortName) {
        [dic setObject:self.repositorySortName forKey:KCONFIG_SORT_REPOSITORY_NAME];
    }
    
    if (self.repositorySortType) {
        [dic setObject:self.repositorySortType forKey:KCONFIG_SORT_REPOSITORY_TYPE];
    }
    
    if (self.loginUsername) {
        [dic setObject:self.loginUsername forKey:KCONFIG_LOGIN_USERNAME];
    }
    
    if (self.loginToken) {
        [dic setObject:self.loginToken forKey:KCONFIG_LOGIN_TOKEN];
    }
    
    return dic;
}

@end
