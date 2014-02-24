//
//  PullRequestModel.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-24.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

@interface PullRequestModel : XDBaseModel

@property (strong, nonatomic) NSString *Id;              //ID
@property (strong, nonatomic) NSString *title;           //标题
@property (strong, nonatomic) NSString *content;         //内容
@property (strong, nonatomic) NSString *createdDateDes; //创建时间描述
@property (strong, nonatomic) NSString *updatedDateDes; //更新时间描述
@property (strong, nonatomic) AccountModel *owner;      //所有者

@end
