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
        self.accountId = [dictionary objectForKey:KACCOUNT_ID];
        self.accountName = [dictionary objectForKey:KACCOUNT_NAME];
        self.avatarUrl = [dictionary objectForKey:KACCOUNT_AVATARURL];
        self.company = [dictionary objectForKey:KACCOUNT_COMPANY];
        self.email = [dictionary objectForKey:KACCOUNT_EMAIL];
        self.webUrl = [dictionary objectForKey:KACCOUNT_WEBURL];
        self.locationDes = [dictionary objectForKey:KACCOUNT_LOCATION];
        self.followersCount = [NSString stringWithFormat:@"%d", [[dictionary objectForKey:KACCOUNT_FOLLOWER] integerValue]];
        self.followingCount = [NSString stringWithFormat:@"%d", [[dictionary objectForKey:KACCOUNT_FOLLOWING] integerValue]];
        self.accountType = [dictionary objectForKey:KACCOUNT_TYPE];
    }
    
    return self;
}

@end
