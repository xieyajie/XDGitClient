//
//  UserModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "DXBaseModel.h"

#define KUSER_COMPANY @"company"
#define KUSER_EMAIL @"email"
#define KUSER_WEBURL @"html_url"
#define KUSER_LOCATION @"location"
#define KUSER_FOLLOWER @"followers"
#define KUSER_FOLLOWING @"following"

@interface UserModel : DXBaseModel

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
