//
//  GitModel.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "GitModel.h"

@implementation GitModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.Id = [dictionary objectForKey:KGIT_ID];
        self.description = [dictionary objectForKey:KGIT_DESC];
        self.createDateDes = [dictionary objectForKey:KGIT_CREATE];
        self.updateDateDes = [dictionary objectForKey:KGIT_UPDATE];
        self.htmlUrl = [dictionary objectForKey:KGIT_HTMLURL];
        self.forksUrl = [dictionary objectForKey:KGIT_FORKURL];
        self.commentCountDes = [dictionary objectForKey:KGIT_COMMENTCOUNT];
        self.isPublic = [[dictionary objectForKey:KGIT_PUBLICSTATE] boolValue];
    }
    
    return self;
}

@end
