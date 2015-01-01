//
//  GitModel.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "GitModel.h"

@implementation GitModel

@synthesize gId = _gId;
@synthesize describe = _describe;
@synthesize createDateDes = _createDateDes;
@synthesize updateDateDes = _updateDateDes;
@synthesize htmlUrl = _htmlUrl;
@synthesize forksUrl = _forksUrl;
@synthesize commentCountDes = _commentCountDes;
@synthesize isPublic = _isPublic;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.gId = [dictionary safeStringForKey:KMODEL_ID];
        self.describe = [dictionary safeStringForKey:KGIT_DESC];
        self.createDateDes = [dictionary safeStringForKey:KMODEL_CREATE];
        self.updateDateDes = [dictionary safeStringForKey:KMODEL_UPDATE];
        self.htmlUrl = [dictionary safeStringForKey:KGIT_HTMLURL];
        self.forksUrl = [dictionary safeStringForKey:KGIT_FORKURL];
        self.commentCountDes = [dictionary safeStringForKey:KGIT_COMMENTCOUNT];
        self.isPublic = [[dictionary objectForKey:KGIT_PUBLICSTATE] boolValue];
    }
    
    return self;
}

@end
