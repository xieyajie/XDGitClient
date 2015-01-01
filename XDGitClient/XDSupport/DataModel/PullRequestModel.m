//
//  PullRequestModel.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-24.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "PullRequestModel.h"

@implementation PullRequestModel

@synthesize prId = _prId;
@synthesize title = _title;
@synthesize content = _content;
@synthesize createdDateDes = _createdDateDes;
@synthesize updatedDateDes = _updatedDateDes;
@synthesize owner = _owner;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.prId = [dictionary safeStringForKey:KMODEL_ID];
        self.title = [dictionary safeStringForKey:KPULLREQUEST_TITLE];
        self.content = [dictionary safeStringForKey:KPULLREQUEST_CONTENT];
        self.createdDateDes = [dictionary objectForKey:KMODEL_CREATE];
        self.updatedDateDes = [dictionary objectForKey:KMODEL_UPDATE];
        self.owner = [[UserModel alloc] initWithDictionary:[dictionary objectForKey:KPULLREQUEST_OWNER]];
    }
    
    return self;
}


@end
