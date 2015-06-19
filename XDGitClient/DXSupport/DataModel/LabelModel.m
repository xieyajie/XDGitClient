//
//  LabelModel.m
//  XDGitClient
//
//  Created by dhcdht on 15-1-1.
//  Copyright (c) 2015年 XDIOS. All rights reserved.
//

#import "LabelModel.h"

@implementation LabelModel

@synthesize url = _url;
@synthesize name = _name;
@synthesize colorDes = _colorDes;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.url = [dictionary objectForKey:KMODEL_URL];
        self.name = [dictionary objectForKey:KLABEL_NAME];
        self.colorDes = [dictionary objectForKey:KLABEL_COLOR];
    }
    
    return self;
}

@end
