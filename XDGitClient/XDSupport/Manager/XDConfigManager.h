//
//  XDConfigManager.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XDConfigManager : NSObject

@property (strong, nonatomic, readonly) NSString *configDirectoryPath;
@property (strong, nonatomic, readonly) NSString *configFilePath;
@property (strong, nonatomic) NSMutableDictionary *configDictionary;

@property (strong, nonatomic) AccountModel *loginAccount;//登录账号

//setting
@property (strong, nonatomic) NSString *repositorySortName;
@property (strong, nonatomic) NSString *repositorySortType;

+ (XDConfigManager *)defaultManager;

- (AFHTTPRequestOperation *)loadLoginAccountWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

- (BOOL)didSave;
- (void)didReset;
- (AFHTTPRequestOperation *)didResetWithSuccess:(XDGitEngineSuccessBlock)successBlock failure:(XDGitEngineFailureBlock)failureBlock;

@end
