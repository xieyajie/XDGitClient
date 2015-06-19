//
//  RepoSourceModel.h
//  XDGitClient
//
//  Created by dhcdht on 15-1-15.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "DXBaseModel.h"

@interface RepoSourceModel : DXBaseModel

@property (nonatomic, strong) NSString *downloadPath;
@property (nonatomic, strong) NSString *gitPath;
@property (nonatomic, strong) NSString *htmlPath;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *sha;
@property (nonatomic) long long size;
@property (nonatomic) XDSourceType type;
@property (nonatomic, strong) NSString *contentsPath;

- (NSString *)imageName;
- (UITableViewCellAccessoryType)cellAccessoryType;

@end
