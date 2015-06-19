//
//  AppConfigModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-11.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppConfigModel : NSObject

@property (strong, nonatomic) NSString *loginUsername;
@property (strong, nonatomic) NSString *loginToken;

@property (strong, nonatomic) NSString *repositorySortName;
@property (strong, nonatomic) NSString *repositorySortType;

- (id)initWithDictionary:(NSDictionary *)dictionary;

- (NSDictionary *)dictionaryForValues;

@end
