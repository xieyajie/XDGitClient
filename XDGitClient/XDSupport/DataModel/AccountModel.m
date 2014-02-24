//
//  AccountModel.m
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "AccountModel.h"

@implementation AccountModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.accountId = [dictionary safeStringForKey:KACCOUNT_ID];
        self.accountName = [dictionary safeStringForKey:KACCOUNT_NAME];
        self.avatarUrl = [dictionary safeStringForKey:KACCOUNT_AVATARURL];
        self.company = [dictionary safeStringForKey:KACCOUNT_COMPANY];
        self.email = [dictionary safeStringForKey:KACCOUNT_EMAIL];
        self.webUrl = [dictionary safeStringForKey:KACCOUNT_WEBURL];
        self.locationDes = [dictionary safeStringForKey:KACCOUNT_LOCATION];
        self.followersCount = [dictionary safeStringForKey:KACCOUNT_FOLLOWER];
        self.followingCount = [dictionary safeStringForKey:KACCOUNT_FOLLOWING];
        self.accountType = [dictionary safeStringForKey:KACCOUNT_TYPE];
    }
    
    return self;
}

@end
