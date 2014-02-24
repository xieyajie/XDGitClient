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
    XDRepositoryStyleAll   = 0,
    XDRepositoryStyleOwner,
    XDRepositoryStyleMember,
    XDRepositoryStyleForks,
    XDRepositoryStyleStars,
    XDRepositoryStyleWatchs,
    XDRepositoryStylePublic,
    XDRepositoryStylePrivate,
    XDRepositoryStyleSource,
    XDRepositoryStyleMirrors,
}XDRepositoryStyle;

typedef enum{
    XDGitStyleAll   = 0,
    XDGitStylePublic,
    XDGitStylePrivate,
    XDGitStyleStarred,
}XDGitStyle;

typedef enum{
    XDPullRequestStateOpen   = 0,
    XDPullRequestStateClosed,
}XDPullRequestState;

//block
#pragma mark - block
typedef void (^XDGitEngineSuccessBlock)(id object);
typedef void (^XDGitEngineBooleanSuccessBlock)(BOOL success);
typedef void (^XDGitEnginePageSuccessBlock)(id object, BOOL haveNextPage);
typedef void (^XDGitEngineFailureBlock)(NSError *error);

//plist key
#pragma mark - plist key
#define KPLIST_KEYIMAGE @"icon"
#define KPLIST_KEYTITLE @"title"
#define KPLIST_KEYMODELSELECTOR @"model_selector"
#define KPLIST_KEYCONTROLLERSELECTOR @"controller_selector"
#define KPLIST_KEYACCESSORYTYPE @"accessoryType"

//plist value controller selector tag

//base
#define KPLIST_VALUE_CONTROLLERSELECTOR_EVENT       100
#define KPLIST_VALUE_CONTROLLERSELECTOR_NOTIF       101

//account
#define KPLIST_VALUE_CONTROLLERSELECTOR_REPO        110
#define KPLIST_VALUE_CONTROLLERSELECTOR_GIT         111
#define KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOWER    112
#define KPLIST_VALUE_CONTROLLERSELECTOR_FOLLOEIMG   113

//repo
#define KPLIST_VALUE_CONTROLLERSELECTOR_ACCOUNT     120
#define KPLIST_VALUE_CONTROLLERSELECTOR_FORKORIGIN  121
#define KPLIST_VALUE_CONTROLLERSELECTOR_ISSUE       122
#define KPLIST_VALUE_CONTROLLERSELECTOR_PULLREQUEST 123
#define KPLIST_VALUE_CONTROLLERSELECTOR_FORKER      124
#define KPLIST_VALUE_CONTROLLERSELECTOR_STARER      125
#define KPLIST_VALUE_CONTROLLERSELECTOR_WATCHER     126
#define KPLIST_VALUE_CONTROLLERSELECTOR_REPOSOURCE  127

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
#define KREPO_PUSH @"pushed_at"
#define KREPO_SIZE @"size"
#define KREPO_LANGUAGE @"language"
#define KREPO_OWNER @"owner"
#define KREPO_DEFAULTBRANCH @"default_branch"
#define KREPO_FORKSCOUNT @"forks_count"
#define KREPO_OPENISSUESCOUNT @"open_issues_count"
#define KREPO_WATCHERSCOUNT @"watchers_count"
#define KREPO_STARSCOUNT @"stargazers_count"
#define KREPO_PRIVATESTATE @"private"
#define KREPO_FORKSTATE @"fork"

//git
#define KGIT_ID @"id"
#define KGIT_DESC @"description"
#define KGIT_CREATE @"created_at"
#define KGIT_UPDATE @"updated_at"
#define KGIT_HTMLURL @"html_url"
#define KGIT_FORKURL @"forks_url"
#define KGIT_COMMENTCOUNT @"comments"
#define KGIT_PUBLICSTATE @"public"

//pull request
#define KPULLREQUEST_ID @"id"
#define KPULLREQUEST_TITLE @"title"
#define KPULLREQUEST_CONTENT @"body"
#define KPULLREQUEST_CREATE @"created_at"
#define KPULLREQUEST_UPDATE @"updated_at"
#define KPULLREQUEST_OWNER @"user"

//#define KPULLREQUEST_ @""
//#define KPULLREQUEST_ @""

#endif
