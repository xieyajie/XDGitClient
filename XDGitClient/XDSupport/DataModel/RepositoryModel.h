//
//  RepositoryModel.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryModel : NSObject

@property (strong, nonatomic) NSString *Id;             //ID
@property (strong, nonatomic) NSString *name;           //项目名称
@property (strong, nonatomic) NSString *fullName;       //项目全称
@property (strong, nonatomic) NSString *description;    //描述
@property (strong, nonatomic) NSString *createDateDes;  //创建时间描述
@property (strong, nonatomic) NSString *updateDateDes;  //更新时间描述
@property (strong, nonatomic) NSString *sizeDes;        //大小描述
@property (strong, nonatomic) NSString *language;       //语言

@property (nonatomic) BOOL isPrivate; //是否私有
@property (nonatomic) BOOL isFork;    //是否拷贝其他人的

//url
@property (strong, nonatomic) NSString *cloneUrl;    //clone
@property (strong, nonatomic) NSString *svnUrl;      //svn
@property (strong, nonatomic) NSString *gitUrl;      //git


@property (strong, nonatomic) NSString *forksCountDes;     //
@property (strong, nonatomic) NSString *issuesCountDeS;    //
@property (strong, nonatomic) NSString *watchersCountDes;  //
@property (strong, nonatomic) NSString *starsCountDes;     //

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
