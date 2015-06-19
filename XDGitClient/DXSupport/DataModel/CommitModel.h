//
//  CommitModel.h
//  XDGitClient
//
//  Created by dhcdht on 14-12-19.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

#define KCOMMIT_AUTHOR @"author"
#define KCOMMIT_AUTHOR_NAME @"name"
#define KCOMMIT_AUTHOR_EMAIL @"email"
#define KCOMMIT_DISTINCT @"distinct"
#define KCOMMIT_MESSAGE @"message"

@interface CommitModel : XDBaseModel

@property (strong, nonatomic) NSString *authorEmail;
@property (strong, nonatomic) NSString *authorName;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *distinct;
@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *sha;

@end
