//
//  GitModel.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

#define KGIT_DESC @"description"
#define KGIT_HTMLURL @"html_url"
#define KGIT_FORKURL @"forks_url"
#define KGIT_COMMENTCOUNT @"comments"
#define KGIT_PUBLICSTATE @"public"

@interface GitModel : XDBaseModel

@property (strong, nonatomic) NSString *gId;             //ID
@property (strong, nonatomic) NSString *describe;    //描述
@property (strong, nonatomic) NSString *createDateDes;  //创建时间描述
@property (strong, nonatomic) NSString *updateDateDes;  //更新时间描述

@property (nonatomic) BOOL isPublic;  //是否公开

//url
@property (strong, nonatomic) NSString *htmlUrl;     //html
@property (strong, nonatomic) NSString *forksUrl;    //fork

//count
@property (strong, nonatomic) NSString *commentCountDes;

@end
