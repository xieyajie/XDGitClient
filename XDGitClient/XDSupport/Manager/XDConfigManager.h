//
//  XDConfigManager.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AccountModel.h"

@interface XDConfigManager : NSObject

@property (strong, nonatomic, readonly) NSString *configDirectoryPath;
@property (strong, nonatomic, readonly) NSString *configFilePath;

@property (strong, nonatomic) AccountModel *loginAccount;

+ (XDConfigManager *)defaultManager;

- (void)loadConfigFilePath;

@end
