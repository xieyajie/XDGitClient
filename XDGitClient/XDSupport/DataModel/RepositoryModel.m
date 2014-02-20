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
        self.createDateDes = [dictionary objectForKey:KREPO_CREATE];
        self.updateDateDes = [dictionary objectForKey:KREPO_UPDATE];
        self.language = [dictionary objectForKey:KREPO_LANGUAGE];
        self.cloneUrl = [dictionary objectForKey:KREPO_CLONEURL];
        self.svnUrl = [dictionary objectForKey:KREPO_SVNURL];
        self.gitUrl = [dictionary objectForKey:KREPO_GITURL];
        self.forksCountDes = [[dictionary objectForKey:KREPO_FORKSCOUNT] stringValue];
        self.issuesCountDeS = [[dictionary objectForKey:KREPO_OPENISSUESCOUNT] stringValue];
        self.watchersCountDes = [[dictionary objectForKey:KREPO_WATCHERSCOUNT] stringValue];
        self.starsCountDes = [[dictionary objectForKey:KREPO_STARSCOUNT] stringValue];
        self.isPrivate = [[dictionary objectForKey:KREPO_PRIVATESTATE] boolValue];
        self.isFork = [[dictionary objectForKey:KREPO_FORKSTATE] boolValue];
        
        self.description = [dictionary objectForKey:KREPO_DESC];
        if ([self.description isEqual:[NSNull null]]) {
            self.description = nil;
        }
        
//        self.sizeDes = [dictionary objectForKey:KREPO_SIZE];
    }
    
    return self;
}

@end
