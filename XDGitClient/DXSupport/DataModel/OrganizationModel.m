//
//  OrganizationModel.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "OrganizationModel.h"

@implementation OrganizationModel

@synthesize oId = _oId;
@synthesize name = _name;
@synthesize avatarUrl = _avatarUrl;
@synthesize gravatarId = _gravatarId;
@synthesize url = _url;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.oId = [dictionary safeStringForKey:KMODEL_ID];
        self.name = [dictionary safeStringForKey:KMODEL_LOGIN];
        self.avatarUrl = [dictionary safeStringForKey:KMODEL_AVATARURL];
        self.gravatarId = [dictionary safeStringForKey:KORG_GRAVATARID];
        self.url = [dictionary safeStringForKey:KMODEL_URL];
    }
    
    return self;
}

@end
