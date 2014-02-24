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
        self.Id = [dictionary safeStringForKey:KGIT_ID];
        self.description = [dictionary safeStringForKey:KGIT_DESC];
        self.createDateDes = [dictionary safeStringForKey:KGIT_CREATE];
        self.updateDateDes = [dictionary safeStringForKey:KGIT_UPDATE];
        self.htmlUrl = [dictionary safeStringForKey:KGIT_HTMLURL];
        self.forksUrl = [dictionary safeStringForKey:KGIT_FORKURL];
        self.commentCountDes = [dictionary safeStringForKey:KGIT_COMMENTCOUNT];
        self.isPublic = [[dictionary objectForKey:KGIT_PUBLICSTATE] boolValue];
    }
    
    return self;
}

@end
