//
//  FileModel.m
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "FileModel.h"

@implementation FileModel

@synthesize content = _content;
@synthesize downloadPath = _downloadPath;
@synthesize gitPath = _gitPath;
@synthesize htmlPath = _htmlPath;
@synthesize name = _name;
@synthesize path = _path;
@synthesize sha = _sha;
@synthesize size = _size;
@synthesize encoding = _encoding;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.content = [dictionary objectForKey:KREPO_FILE_CONTENT];
        self.downloadPath = [dictionary objectForKey:KREPO_FILE_DOWNLOADPATH];
        self.gitPath = [dictionary objectForKey:KREPO_FILE_GIT];
        self.htmlPath = [dictionary objectForKey:KREPO_FILE_BROWSERPATH];
        self.name = [dictionary objectForKey:KREPO_FILE_NAME];
        self.path = [dictionary objectForKey:KREPO_FILE_PATH];
        self.sha = [dictionary objectForKey:KMODEL_SHA];
        self.size = [[dictionary objectForKey:KMODEL_SIZE] longLongValue];
        self.encoding = [dictionary objectForKey:KREPO_FILE_ENCODING];
    }
    
    return self;
}

@end
