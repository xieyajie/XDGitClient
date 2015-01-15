//
//  CommitModel.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "CommitModel.h"

@implementation CommitModel

@synthesize authorEmail = _authorEmail;
@synthesize authorName = _authorName;
@synthesize message = _message;
@synthesize distinct = _distinct;
@synthesize url = _url;
@synthesize sha = _sha;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.message = [dictionary safeStringForKey:KCOMMIT_MESSAGE];
        self.distinct = [dictionary safeStringForKey:KCOMMIT_DISTINCT];
        self.sha = [dictionary safeStringForKey:KMODEL_SHA];
        self.url = [dictionary safeStringForKey:KMODEL_URL];
        
        NSDictionary *author = [dictionary objectForKey:KCOMMIT_AUTHOR];
        self.authorName = [author safeStringForKey:KCOMMIT_AUTHOR_NAME];
        self.authorEmail = [author safeStringForKey:KCOMMIT_AUTHOR_EMAIL];
    }
    
    return self;
}


@end
