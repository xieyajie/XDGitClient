//
//  OrganizationModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

@interface OrganizationModel : XDBaseModel

@property (strong, nonatomic) NSString *oid;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatarUrl;
@property (strong, nonatomic) NSString *gravatarId;
@property (strong, nonatomic) NSString *url;

@end
