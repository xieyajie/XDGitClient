//
//  NSString+Category.h
//  XDGitClient
//
//  Created by xieyajie on 14-2-18.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Category)

- (NSDate *)dateFromGithubDateString;
- (NSString *)encodedString;

- (NSString *)fileSizeDescription;
- (NSString *)dateDes;

@end
