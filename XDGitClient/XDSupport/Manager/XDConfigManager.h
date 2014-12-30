//
//  XDConfigManager.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AppConfigModel.h"

@interface XDConfigManager : NSObject

@property (strong, nonatomic, readonly) NSString *configFilePath;//配置文件本地路径

@property (strong, nonatomic, readonly) AppConfigModel *appConfig;//内存中的配置信息

@property (strong, nonatomic) NSString *loginToken;//登录token

@property (strong, nonatomic) UserModel *loginUser;//登录账号

+ (XDConfigManager *)defaultManager;

@end
