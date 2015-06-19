//
//  LabelModel.h
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "XDBaseModel.h"

#define KLABEL_NAME @"name"
#define KLABEL_COLOR @"color"

@interface LabelModel : XDBaseModel

@property (strong, nonatomic) NSString *url;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *colorDes;

@end
