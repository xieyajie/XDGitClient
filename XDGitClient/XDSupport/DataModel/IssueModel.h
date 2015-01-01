//
//  IssueModel.h
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

#import "LabelModel.h"

#define KISSUE_STATE @"state"
#define KISSUE_TITLE @"title"
#define KISSUE_CONTENT @"body"
#define KISSUE_USER @"user"
#define KISSUE_LABEL @"labels"
#define KISSUE_ASSIGNEE @"assignee"
#define KISSUE_COMMENTCOUNT @"comments"
#define KISSUE_CLOSED @"closed_at"

@interface IssueModel : XDBaseModel

@property (strong, nonatomic) NSString *iId;
@property (strong, nonatomic) NSString *stateDes;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *closedDateDes;
@property (strong, nonatomic) NSString *createDateDes;
@property (strong, nonatomic) NSString *updateDateDes;
@property (nonatomic) NSInteger commentCount;
@property (strong, nonatomic) NSMutableArray *labelsModel;

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *userAvatarUrl;

@property (strong, nonatomic) NSString *assigneeId;
@property (strong, nonatomic) NSString *assigneeName;
@property (strong, nonatomic) NSString *assigneeAvatarUrl;

@end
