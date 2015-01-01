//
//  EventModel.m
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "EventModel.h"

@implementation EventModel

@synthesize eId = _eId;
@synthesize createdDateDes = _createdDateDes;
@synthesize typeDes = _typeDes;
@synthesize isPublic = _isPublic;
@synthesize user = _user;
@synthesize organization = _organization;
@synthesize repository = _repository;

@synthesize commitModels = _commitModels;
@synthesize plPushId = _plPushId;
@synthesize plHead = _plHead;
@synthesize plDistinctSizeDes = _plDistinctSizeDes;
@synthesize plRef = _plRef;
@synthesize plSizeDes = _plSizeDes;
@synthesize plBefore = _plBefore;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.eId = [dictionary objectForKey:KMODEL_ID];
        self.createdDateDes = [dictionary objectForKey:KMODEL_CREATE];
        self.typeDes = [dictionary objectForKey:KMODEL_TYPE];
        self.isPublic = [[dictionary objectForKey:KEVENT_PUBLICSTATE] boolValue];
        
        NSDictionary *userDic = [dictionary objectForKey:KEVENT_USER];
        self.user = [[UserModel alloc] initWithDictionary:userDic];
        
        NSDictionary *orgDic = [dictionary objectForKey:KEVENT_ORG];
        self.organization = [[OrganizationModel alloc] initWithDictionary:orgDic];
        
        NSDictionary *repoDic = [dictionary objectForKey:KEVENT_REPO];
        self.repository = [[RepositoryModel alloc] initWithDictionary:repoDic];
        
        self.commitModels = [NSMutableArray array];
        NSDictionary *payload = [dictionary objectForKey:KEVENT_PAYLOAD];
        if ([payload count] > 0) {
            self.plPushId = [dictionary objectForKey:KEVENT_PAYLOAD_ID];
            self.plHead = [dictionary objectForKey:KEVENT_PAYLOAD_HEAD];
            self.plDistinctSizeDes = [dictionary objectForKey:KEVENT_PAYLOAD_DISTINCTSIZE];
            self.plRef = [dictionary objectForKey:KEVENT_PAYLOAD_RER];
            self.plSizeDes = [dictionary objectForKey:KMODEL_SIZE];
            self.plBefore = [dictionary objectForKey:KEVENT_PAYLOAD_BEFORE];
            
            NSArray *commitsArray = [dictionary objectForKey:KEVENT_PAYLOAD_COMMITS];
            if ([commitsArray count] > 0) {
                for (NSDictionary *dic in commitsArray) {
                    CommitModel *cm = [[CommitModel alloc] initWithDictionary:dic];
                    [self.commitModels addObject:cm];
                }
            }
        }
    }
    
    return self;
}

@end
