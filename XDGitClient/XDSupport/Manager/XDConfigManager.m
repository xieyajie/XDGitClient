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

@synthesize configFilePath = _configFilePath;
@synthesize appConfig = _appConfig;

@synthesize loginToken = _loginToken;
@synthesize loginAccount = _loginAccount;

- (id)init
{
    self = [super init];
    if (self) {
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _configFilePath = [documentPath stringByAppendingPathComponent:KCONFIG_FILE];
        NSFileManager *fm = [NSFileManager defaultManager];
        if (![fm fileExistsAtPath:_configFilePath]) {
            [fm createFileAtPath:_configFilePath contents:nil attributes:nil];
        }
        
        [self _loadConfigInfo];
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

#pragma mark - private

- (void)_loadConfigInfo
{
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:_configFilePath];
    _appConfig = [[AppConfigModel alloc] initWithDictionary:dic];
    _loginToken = _appConfig.loginToken;
    [[XDGithubEngine shareEngine] setToken:_loginToken];
}

#pragma mark - 

- (void)setLoginToken:(NSString *)loginToken
{
    if (!_loginToken || ![_loginToken isEqualToString:loginToken]) {
        _appConfig.loginToken = loginToken;
        _loginToken = loginToken;
        [self save];
    }
}

- (void)setLoginAccount:(AccountModel *)loginAccount
{
    _loginAccount = loginAccount;
    
    if (![_appConfig.loginUsername isEqualToString:loginAccount.accountName]) {
        _appConfig.loginUsername = loginAccount.accountName;
        [self save];
    }
}

#pragma mark - public

- (BOOL)save
{
    BOOL ret = YES;
    NSDictionary *dic = [_appConfig dictionaryForValues];
    if ([dic count] > 0) {
        ret = [dic writeToFile:_configFilePath atomically:YES];
    }
    return ret;
}

//- (AFHTTPRequestOperation *)loadLoginAccountWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    AFHTTPRequestOperation *operation = [[XDGithubEngine shareEngine] userWithSuccess:^(id object, BOOL haveNextPage) {
//        AccountModel *account = [[AccountModel alloc] initWithDictionary:object];
//        self.loginAccount = account;
//        successBlock(account);
//    } failure:^(NSError *error) {
//        self.loginAccount = nil;
//        failureBlock(error);
//    }];
//    
//    return operation;
//}
//
//- (AFHTTPRequestOperation *)didResetWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock
//{
//    [self _loadConfigInfo];
//    return [self loadLoginAccountWithSuccess:successBlock failure:failureBlock];
//}

@end
