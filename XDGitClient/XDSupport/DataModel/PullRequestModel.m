//
//  PullRequestModel.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-24.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "PullRequestModel.h"

@implementation PullRequestModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.Id = [dictionary safeStringForKey:KPULLREQUEST_ID];
        self.title = [dictionary safeStringForKey:KPULLREQUEST_TITLE];
        self.content = [dictionary safeStringForKey:KPULLREQUEST_CONTENT];
        self.createdDateDes = [dictionary objectForKey:KPULLREQUEST_CREATE];
        self.updatedDateDes = [dictionary objectForKey:KPULLREQUEST_UPDATE];
        self.owner = [[AccountModel alloc] initWithDictionary:[dictionary objectForKey:KPULLREQUEST_OWNER]];
    }
    
    return self;
}


@end
