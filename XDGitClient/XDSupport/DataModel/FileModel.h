//
//  FileModel.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-20.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

#define KREPO_FILE_CONTENT @"content"
#define KREPO_FILE_DOWNLOADPATH @"download_url"
#define KREPO_FILE_GIT @"git_url"
#define KREPO_FILE_BROWSERPATH @"html_url"
#define KREPO_FILE_ENCODING @"encoding"
#define KREPO_FILE_NAME @"name"
#define KREPO_FILE_PATH @"path"

@interface FileModel : XDBaseModel

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *downloadPath;
@property (strong, nonatomic) NSString *gitPath;
@property (strong, nonatomic) NSString *htmlPath;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *path;
@property (strong, nonatomic) NSString *sha;
@property (strong, nonatomic) NSString *encoding;
@property (nonatomic) long long size;

@end
