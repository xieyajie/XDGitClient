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
        self.Id = [dictionary objectForKey:KREPO_ID];
        self.name = [dictionary objectForKey:KREPO_NAME];
        self.fullName = [dictionary objectForKey:KREPO_FULLNAME];
        self.createdDateDes = [dictionary objectForKey:KREPO_CREATE];
        self.updatedDateDes = [dictionary objectForKey:KREPO_UPDATE];
        self.pushedDateDes = [dictionary objectForKey:KREPO_PUSH];
        self.language = [dictionary objectForKey:KREPO_LANGUAGE];
        self.sizeDes = [[[dictionary objectForKey:KREPO_SIZE] stringValue] fileSizeDescription];
        self.description = [dictionary objectForKey:KREPO_DESC];
        if ([self.description isEqual:[NSNull null]]) {
            self.description = nil;
        }
        self.owner = [[AccountModel alloc] initWithDictionary:[dictionary objectForKey:KREPO_OWNER]];
        self.defaultBranch = [dictionary objectForKey:KREPO_DEFAULTBRANCH];

        self.forksCountDes = [[dictionary objectForKey:KREPO_FORKSCOUNT] stringValue];
        self.issuesCountDes = [[dictionary objectForKey:KREPO_OPENISSUESCOUNT] stringValue];
        self.watchersCountDes = [[dictionary objectForKey:KREPO_WATCHERSCOUNT] stringValue];
        self.starsCountDes = [[dictionary objectForKey:KREPO_STARSCOUNT] stringValue];
        
        self.isPrivate = [[dictionary objectForKey:KREPO_PRIVATESTATE] boolValue];
        self.isFork = [[dictionary objectForKey:KREPO_FORKSTATE] boolValue];
        
        self.ownerName = self.owner ? self.owner.accountName : @"";
        self.purviewDes = self.isPrivate ? @"Private" : @"Public";
    }
    
    return self;
}

@end
