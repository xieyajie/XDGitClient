//
//  GitModel.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

@interface GitModel : XDBaseModel

@property (strong, nonatomic) NSString *Id;             //ID
@property (strong, nonatomic) NSString *description;    //描述
@property (strong, nonatomic) NSString *createDateDes;  //创建时间描述
@property (strong, nonatomic) NSString *updateDateDes;  //更新时间描述

@property (nonatomic) BOOL isPublic;  //是否公开

//url
@property (strong, nonatomic) NSString *htmlUrl;     //html
@property (strong, nonatomic) NSString *forksUrl;    //fork

//count
@property (strong, nonatomic) NSString *commentCountDes;

@end
