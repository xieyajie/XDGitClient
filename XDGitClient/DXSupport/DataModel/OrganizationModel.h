//
//  OrganizationModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "DXBaseModel.h"

#define KORG_GRAVATARID @"gravatar_id"

@interface OrganizationModel : DXBaseModel

@property (strong, nonatomic) NSString *oId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *avatarUrl;
@property (strong, nonatomic) NSString *gravatarId;
@property (strong, nonatomic) NSString *url;

@end
