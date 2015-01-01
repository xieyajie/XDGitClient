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

@synthesize rId = _rId;
@synthesize name = _name;
@synthesize fullName = _fullName;
@synthesize describe = _describe;
@synthesize createdDateDes = _createdDateDes;
@synthesize updatedDateDes = _updatedDateDes;
@synthesize pushedDateDes = _pushedDateDes;
@synthesize sizeDes = _sizeDes;
@synthesize language = _language;
@synthesize owner = _owner;
@synthesize defaultBranch = _defaultBranch;

@synthesize isPrivate = _isPrivate;
@synthesize isFork = _isFork;

@synthesize forksCountDes = _forksCountDes;
@synthesize issuesCountDes = _issuesCountDes;
@synthesize watchersCountDes = _watchersCountDes;
@synthesize starsCountDes = _starsCountDes;

@synthesize ownerName = _ownerName;
@synthesize purviewDes = _purviewDes;
@synthesize url = _url;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.rId = [dictionary safeStringForKey:KMODEL_ID];
        self.name = [dictionary safeStringForKey:KREPO_NAME];
        self.fullName = [dictionary safeStringForKey:KREPO_FULLNAME];
        self.createdDateDes = [dictionary safeStringForKey:KMODEL_CREATE];
        self.updatedDateDes = [dictionary safeStringForKey:KMODEL_UPDATE];
        self.pushedDateDes = [dictionary safeStringForKey:KREPO_PUSH];
        self.language = [dictionary safeStringForKey:KREPO_LANGUAGE];
        self.sizeDes = [[dictionary safeStringForKey:KMODEL_SIZE] fileSizeDescription];
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
        self.url = [dictionary safeStringForKey:KMODEL_URL];
    }
    
    return self;
}

@end
