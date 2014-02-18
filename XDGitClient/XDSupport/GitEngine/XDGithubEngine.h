//
//  XDGithubEngine.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XDGitEngineProtocol.h"
#import "XDGitRequestClient.h"

@interface XDGithubEngine : NSObject<XDGitEngineProtocol>
{
    XDGitRequestClient *_requestClient;
}

@end
