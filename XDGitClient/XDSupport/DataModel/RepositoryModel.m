//
//  RepositoryModel.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "RepositoryModel.h"

#import "NSString+Category.h"

@implementation RepositoryModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.rid = [dictionary safeStringForKey:KREPO_ID];
        self.name = [dictionary safeStringForKey:KREPO_NAME];
        self.fullName = [dictionary safeStringForKey:KREPO_FULLNAME];
        self.createdDateDes = [dictionary safeStringForKey:KREPO_CREATE];
        self.updatedDateDes = [dictionary safeStringForKey:KREPO_UPDATE];
        self.pushedDateDes = [dictionary safeStringForKey:KREPO_PUSH];
        self.language = [dictionary safeStringForKey:KREPO_LANGUAGE];
        self.sizeDes = [[dictionary safeStringForKey:KREPO_SIZE] fileSizeDescription];
        self.describe = [dictionary safeStringForKey:KREPO_DESC];
        self.owner = [[UserModel alloc] initWithDictionary:[dictionary objectForKey:KREPO_OWNER]];
        self.defaultBranch = [dictionary safeStringForKey:KREPO_DEFAULTBRANCH];

        self.forksCountDes = [dictionary safeStringForKey:KREPO_FORKSCOUNT];
        self.issuesCountDes = [dictionary safeStringForKey:KREPO_OPENISSUESCOUNT];
        self.watchersCountDes = [dictionary safeStringForKey:KREPO_WATCHERSCOUNT];
        self.starsCountDes = [dictionary safeStringForKey:KREPO_STARSCOUNT];
        
        self.isPrivate = [[dictionary objectForKey:KREPO_PRIVATESTATE] boolValue];
        self.isFork = [[dictionary objectForKey:KREPO_FORKSTATE] boolValue];
        
        self.ownerName = self.owner ? self.owner.userName : @"";
        self.purviewDes = self.isPrivate ? @"Private" : @"Public";
    }
    
    return self;
}

@end
