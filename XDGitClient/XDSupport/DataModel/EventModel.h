//
//  EventModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

#import "UserModel.h"
#import "CommitModel.h"
#import "RepositoryModel.h"
#import "OrganizationModel.h"

@interface EventModel : XDBaseModel

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
