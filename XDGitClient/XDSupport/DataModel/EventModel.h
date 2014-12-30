//
//  EventModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

#import "UserModel.h"
#import "OrganizationModel.h"

@interface EventModel : XDBaseModel

@property (strong, nonatomic) NSString *eid;
@property (strong, nonatomic) NSString *createdDateDes;
@property (strong, nonatomic) NSString *typeDes;
@property (nonatomic) BOOL isPublic;

@property (strong, nonatomic) NSMutableArray *commitModels;
@property (strong, nonatomic) UserModel *user;
@property (strong, nonatomic) OrganizationModel *organization;

@end
