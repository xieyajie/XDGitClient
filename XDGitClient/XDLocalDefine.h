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
    XDProjectStyleContributed,
    XDProjectStyleForks,
    XDProjectStyleSource,
    XDProjectStyleMirrors,
}XDProjectStyle;

//block
#pragma mark - block
typedef void (^XDGitEngineSuccessBlock)(id object);
typedef void (^XDGitEngineBooleanSuccessBlock)(BOOL success);
typedef void (^XDGitEngineFailureBlock)(NSError *error);

//plist key
#pragma mark - plist key
#define KPLIST_SOURCEIMAGE @"icon"
#define KPLIST_SOURCETITLE @"title"
#define KPLIST_SOURCESELECTOR @"selector"
#define KPLIST_SOURCEACCESSORYTYPE @"accessoryType"

#pragma mark - default

#define KPERPAGENUMBER 50
#define KLEFTVIEWWIDTH 200.0

//textField color (detail)
#define TEXTFIELDDETAILCOLOR [UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1.0]

#pragma mark - NSNotification name
#define KNOTIFICATION_LOFINSTATECHANGED @"LoginStateChanged"

#pragma mark - model

//account
#define KACCOUNT_ID @"id"
#define KACCOUNT_NAME @"login"
#define KACCOUNT_AVATARURL @"avatar_url"
#define KACCOUNT_COMPANY @"company"
#define KACCOUNT_EMAIL @"email"
#define KACCOUNT_WEBURL @"html_url"
#define KACCOUNT_LOCATION @"location"
#define KACCOUNT_FOLLOWER @"followers"
#define KACCOUNT_FOLLOWING @"following"
#define KACCOUNT_TYPE @"type"

//Repository
#define KREPO_ID @"id"
#define KREPO_NAME @"name"
#define KREPO_FULLNAME @"full_name"
#define KREPO_DESC @"description"
#define KREPO_CREATE @"created_at"
#define KREPO_UPDATE @"updated_at"
#define KREPO_SIZE @"size"
#define KREPO_LANGUAGE @"language"
#define KREPO_CLONEURL @"clone_url"
#define KREPO_SVNURL @"svn_url"
#define KREPO_GITURL @"git_url"
#define KREPO_FORKSCOUNT @"forks_count"
#define KREPO_OPENISSUESCOUNT @"open_issues_count"
#define KREPO_WATCHERSCOUNT @"watchers_count"
#define KREPO_STARSCOUNT @"stargazers_count"
//#define KREPO_ @""
//#define KREPO_ @""
//#define KREPO_ @""
//#define KREPO_ @""

#endif
