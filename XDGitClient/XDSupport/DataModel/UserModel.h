//
//  UserModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

@interface UserModel : XDBaseModel

@property (strong, nonatomic) NSString *uId;      //ID
@property (strong, nonatomic) NSString *userName;    //用户名称
@property (strong, nonatomic) NSString *avatarUrl;      //头像网络地址
@property (strong, nonatomic) NSString *userType;    //用户类型
@property (strong, nonatomic) NSString *company;        //公司名称
@property (strong, nonatomic) NSString *email;          //邮箱
@property (strong, nonatomic) NSString *webUrl;         //个人网址
@property (strong, nonatomic) NSString *locationDes;    //地址

@property (strong, nonatomic) NSString *followersCount; //关注我的人的个数
@property (strong, nonatomic) NSString *followingCount; //我关注的人的个数

@property (strong, nonatomic) NSString *url;

@end
