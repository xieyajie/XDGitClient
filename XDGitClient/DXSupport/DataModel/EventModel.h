//
//  EventModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "DXBaseModel.h"

#import "UserModel.h"
#import "CommitModel.h"
#import "RepositoryModel.h"
#import "OrganizationModel.h"

#define KEVENT_PUBLICSTATE @"public"
#define KEVENT_PAYLOAD @"payload"
#define KEVENT_USER @"actor"
#define KEVENT_ORG @"org"
#define KEVENT_REPO @"repo"

#define KEVENT_PAYLOAD_ID @"push_id"
#define KEVENT_PAYLOAD_COMMITS @"commits"
#define KEVENT_PAYLOAD_HEAD @"head"
#define KEVENT_PAYLOAD_DISTINCTSIZE @"distinct_size"
#define KEVENT_PAYLOAD_BEFORE @"before"
#define KEVENT_PAYLOAD_RER @"ref"

@interface EventModel : DXBaseModel

@property (strong, nonatomic) NSString *eId;
@property (strong, nonatomic) NSString *createdDateDes;
@property (strong, nonatomic) NSString *typeDes;
@property (nonatomic) BOOL isPublic;

@property (strong, nonatomic) UserModel *user;
@property (strong, nonatomic) OrganizationModel *organization;
@property (strong, nonatomic) RepositoryModel *repository;

@property (strong, nonatomic) NSMutableArray *commitModels;
@property (strong, nonatomic) NSString *plPushId;
@property (strong, nonatomic) NSString *plHead;
@property (strong, nonatomic) NSString *plDistinctSizeDes;
@property (strong, nonatomic) NSString *plRef;
@property (strong, nonatomic) NSString *plSizeDes;
@property (strong, nonatomic) NSString *plBefore;

@end
