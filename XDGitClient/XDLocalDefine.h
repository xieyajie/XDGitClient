//
//  XDLocalDefine.h
//  XDGitClient
//
//  Created by dhcdht on 14-2-17.
//  Copyright (c) 2014年 XDIOS. All rights reserved.
//

#ifndef XDGitClient_XDLocalDefine_h
#define XDGitClient_XDLocalDefine_h

//enum
#pragma mark - enum
typedef enum{
    XDProjectStyleAll   = 0,
    XDProjectStylePublic,
    XDProjectStylePrivate,
    XDProjectStyleSource,
    XDProjectStyleForks,
    XDProjectStyleMirrors,
    XDProjectStyleContributed,
}XDProjectStyle;

//block
#pragma mark - block
typedef void (^XDGitEngineSuccessBlock)(id object);
typedef void (^XDGitEngineBooleanSuccessBlock)(BOOL success);
typedef void (^XDGitEngineFailureBlock)(NSError *error);

#define KLEFTVIEWWIDTH 190.0

//textField color (detail)
#define TEXTFIELDDETAILCOLOR [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0]

#pragma mark - NSNotification name
#define KNOTIFICATION_LOFINSTATECHANGED @"LoginStateChanged"

#pragma mark - account model
#define KACCOUNT_ID @"id"
#define KACCOUNT_NAME @"login"
#define KACCOUNT_AVATARURL @"avatar_url"
#define KACCOUNT_COMPANY @"company"
#define KACCOUNT_EMAIL @"email"
#define KACCOUNT_FOLLOWER @"followers"
#define KACCOUNT_FOLLOWING @"following"
#define KACCOUNT_TYPE @"type"

#endif
