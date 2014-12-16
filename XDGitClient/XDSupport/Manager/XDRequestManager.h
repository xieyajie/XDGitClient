//
//  XDRequestManager.h
//  leCar
//
//  Created by xieyajie on 13-12-30.
//  Copyright (c) 2013年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XDGithubEngine.h"

@interface XDRequestManager : NSObject

@property (strong, nonatomic) XDGithubEngine *githubEngine;

+ (XDRequestManager *)defaultManager;

@end
