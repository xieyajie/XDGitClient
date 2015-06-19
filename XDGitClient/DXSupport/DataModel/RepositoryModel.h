//
//  RepositoryModel.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "DXBaseModel.h"

#define KREPO_NAME @"name"
#define KREPO_FULLNAME @"full_name"
#define KREPO_DESC @"description"
#define KREPO_PUSH @"pushed_at"
#define KREPO_LANGUAGE @"language"
#define KREPO_OWNER @"owner"
#define KREPO_DEFAULTBRANCH @"default_branch"
#define KREPO_FORKSCOUNT @"forks_count"
#define KREPO_OPENISSUESCOUNT @"open_issues_count"
#define KREPO_WATCHERSCOUNT @"watchers_count"
#define KREPO_STARSCOUNT @"stargazers_count"
#define KREPO_PRIVATESTATE @"private"
#define KREPO_FORKSTATE @"fork"

@interface RepositoryModel : DXBaseModel

@property (strong, nonatomic) NSString *rId;             //ID
@property (strong, nonatomic) NSString *name;           //项目名称
@property (strong, nonatomic) NSString *fullName;       //项目全称
@property (strong, nonatomic) NSString *describe;    //描述
@property (strong, nonatomic) NSString *createdDateDes; //创建时间描述
@property (strong, nonatomic) NSString *updatedDateDes; //更新时间描述
@property (strong, nonatomic) NSString *pushedDateDes;  //上传时间描述
@property (strong, nonatomic) NSString *sizeDes;        //大小描述
@property (strong, nonatomic) NSString *language;       //语言
@property (strong, nonatomic) UserModel *owner;      //所有者
@property (strong, nonatomic) NSString *defaultBranch;  //默认分支

@property (nonatomic) BOOL isPrivate; //是否私有
@property (nonatomic) BOOL isFork;    //是否拷贝其他人的

@property (strong, nonatomic) NSString *forksCountDes;     //
@property (strong, nonatomic) NSString *issuesCountDes;    //
@property (strong, nonatomic) NSString *watchersCountDes;  //
@property (strong, nonatomic) NSString *starsCountDes;     //

//衍生信息
@property (strong, nonatomic) NSString *ownerName;
@property (strong, nonatomic) NSString *purviewDes;
@property (strong, nonatomic) NSString *url;

@end
