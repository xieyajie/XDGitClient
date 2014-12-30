//
//  UserModel.m
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.uId = [dictionary safeStringForKey:KUSER_ID];
        self.userName = [dictionary safeStringForKey:KUSER_NAME];
        self.avatarUrl = [dictionary safeStringForKey:KUSER_AVATARURL];
        self.company = [dictionary safeStringForKey:KUSER_COMPANY];
        self.email = [dictionary safeStringForKey:KUSER_EMAIL];
        self.webUrl = [dictionary safeStringForKey:KUSER_WEBURL];
        self.locationDes = [dictionary safeStringForKey:KUSER_LOCATION];
        self.followersCount = [dictionary safeStringForKey:KUSER_FOLLOWER];
        self.followingCount = [dictionary safeStringForKey:KUSER_FOLLOWING];
        self.accountType = [dictionary safeStringForKey:KUSER_TYPE];
    }
    
    return self;
}

@end
