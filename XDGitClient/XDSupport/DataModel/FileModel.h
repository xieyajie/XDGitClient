//
//  FileModel.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileModel : NSObject

@property (strong, nonatomic) NSString *Id;             //ID
@property (strong, nonatomic) NSString *fileName;       //文件名称
@property (strong, nonatomic) NSString *sizeDes;        //大小描述
@property (strong, nonatomic) NSString *language;       //语言
@property (strong, nonatomic) NSString *typeDes;        //类型描述

//url
@property (strong, nonatomic) NSString *rawUrl;       //raw

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
