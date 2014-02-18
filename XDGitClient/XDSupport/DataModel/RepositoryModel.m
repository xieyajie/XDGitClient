//
//  RepositoryModel.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "RepositoryModel.h"

@implementation RepositoryModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.Id = [dictionary objectForKey:KREPO_ID];
        self.name = [dictionary objectForKey:KREPO_NAME];
        self.fullName = [dictionary objectForKey:KREPO_FULLNAME];
        self.description = [dictionary objectForKey:KREPO_DESC];
        self.createDateDes = [dictionary objectForKey:KREPO_CREATE];
        self.updateDateDes = [dictionary objectForKey:KREPO_UPDATE];
        self.sizeDes = [dictionary objectForKey:KREPO_SIZE];
        self.language = [dictionary objectForKey:KREPO_LANGUAGE];
        self.cloneUrl = [dictionary objectForKey:KREPO_CLONEURL];
        self.svnUrl = [dictionary objectForKey:KREPO_SVNURL];
        self.gitUrl = [dictionary objectForKey:KREPO_GITURL];
        self.forksCountDes = [dictionary objectForKey:KREPO_FORKSCOUNT];
        self.issuesCountDeS = [dictionary objectForKey:KREPO_OPENISSUESCOUNT];
        self.watchersCountDes = [dictionary objectForKey:KREPO_WATCHERSCOUNT];
        self.starsCountDes = [dictionary objectForKey:KREPO_STARSCOUNT];
    }
    
    return self;
}

@end
