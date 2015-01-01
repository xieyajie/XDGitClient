//
//  IssueModel.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "IssueModel.h"

@implementation IssueModel

@synthesize iId = _iId;
@synthesize stateDes = _stateDes;
@synthesize title = _title;
@synthesize content = _content;
@synthesize closedDateDes = _closedDateDes;
@synthesize createDateDes = _createDateDes;
@synthesize updateDateDes = _updateDateDes;
@synthesize commentCount = _commentCount;
@synthesize labelsModel = _labelsModel;

@synthesize userId = _userId;
@synthesize userName = _userName;
@synthesize userAvatarUrl = _userAvatarUrl;

@synthesize assigneeId = _assigneeId;
@synthesize assigneeName = _assigneeName;
@synthesize assigneeAvatarUrl = _assigneeAvatarUrl;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.iId = [dictionary objectForKey:KMODEL_ID];
        self.closedDateDes = [dictionary objectForKey:KMODEL_CREATE];
        self.createDateDes = [dictionary objectForKey:KMODEL_CREATE];
        self.updateDateDes = [dictionary objectForKey:KMODEL_CREATE];
        self.stateDes = [dictionary objectForKey:KISSUE_STATE];
        self.title = [dictionary objectForKey:KISSUE_TITLE];
        self.content = [dictionary objectForKey:KISSUE_CONTENT];
        
        NSDictionary *userDic = [dictionary objectForKey:KISSUE_USER];
        self.userId = [userDic objectForKey:KMODEL_ID];
        self.userName = [userDic objectForKey:KMODEL_LOGIN];
        self.userAvatarUrl = [userDic objectForKey:KMODEL_AVATARURL];
        
        NSDictionary *assigneeDic = [dictionary objectForKey:KISSUE_ASSIGNEE];
        self.assigneeId = [assigneeDic objectForKey:KMODEL_ID];
        self.assigneeName = [assigneeDic objectForKey:KMODEL_LOGIN];
        self.assigneeAvatarUrl = [assigneeDic objectForKey:KMODEL_AVATARURL];
        
        self.labelsModel = [NSMutableArray array];
        NSArray *labels = [dictionary objectForKey:KISSUE_LABEL];
        if ([labels count] > 0) {
            for (NSDictionary *dic in labels) {
                LabelModel *lm = [[LabelModel alloc] initWithDictionary:dic];
                [self.labelsModel addObject:lm];
            }
        }
    }
    
    return self;
}

@end
